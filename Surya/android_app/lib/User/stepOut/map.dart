import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:vector_math/vector_math.dart' hide Colors;

class MapHome extends StatefulWidget {
  final String userid;
  MapHome({this.userid});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<MapHome> {
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Marker marker;
  Circle circle;
  List<Marker> markers = [];
  List<Circle> circles = [];
  GoogleMapController _controller;

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(20.5937, 78.9629),
    zoom: 5,
  );

  Future<Uint8List> getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("images/human_marker.png");
    return byteData.buffer.asUint8List();
  }

  void getCurrentLocation() async {
    try {
      Uint8List imageData = await getMarker();
      var location = await _locationTracker.getLocation();

      updateMarkerCircle(location, imageData);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

      _locationSubscription =
          _locationTracker.onLocationChanged.listen((newLocalData) async {
        if (_controller != null) {
          _controller.animateCamera(CameraUpdate.newCameraPosition(
              new CameraPosition(
                  bearing: 192.8334901395799,
                  target: LatLng(newLocalData.latitude, newLocalData.longitude),
                  tilt: 0,
                  zoom: 15)));
          await updateLocationdatabase(newLocalData);
          await initialiseMarkersAnCircles();
          await calculateDistance(newLocalData);
        }
      });
    } catch (e) {
      Alert(
              context: context,
              title: 'Location Error',
              desc: e.toString(),
              buttons: [],
              style:
                  AlertStyle(isCloseButton: false, isOverlayTapDismiss: false))
          .show();
      await Future.delayed(Duration(seconds: 3));
      Navigator.pop(context);
    }
  }

  Future<void> updateMarkerCircle(
      LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    setState(() {
      marker = Marker(
          markerId: MarkerId("${widget.userid}"),
          position: latlng,
          rotation: newLocalData.heading,
          draggable: false,
          zIndex: 2,
          flat: false,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));

      circle = Circle(
          circleId: CircleId(widget.userid),
          radius: newLocalData.accuracy,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
    });
    return null;
  }

  final CollectionReference location =
      FirebaseFirestore.instance.collection('Locations');

  Future<void> updateLocationdatabase(LocationData current) async {
    try {
      location.doc(widget.userid).update({
        'location': GeoPoint(current.latitude, current.longitude),
      });
    } catch (e) {
      print(e.toString());
    }
  }

  double distance(double lat1, double lat2, double long1, double long2) {
    lat1 = radians(lat1);
    lat2 = radians(lat2);
    long1 = radians(long1);
    long2 = radians(long2);
    double dlong = long2 - long1;
    double dlat = lat2 - lat1;
    double ans =
        pow(sin(dlat / 2), 2) + cos(lat1) * cos(lat2) * pow(sin(dlong / 2), 2);
    ans = 2 * asin(sqrt(ans));
    double R = 6371000;
    ans = ans * R;
    return ans;
  }

  final CollectionReference neighbour =
      FirebaseFirestore.instance.collection('Contacted People');

  Future<void> calculateDistance(LocationData current) async {
    try {
      QuerySnapshot result = await location.get();
      List alldata = result.docs;
      DocumentSnapshot userpeopledata =
          await neighbour.doc(widget.userid).get();
      List userpeople = userpeopledata.data()['Contacted_People'];
      for (int i = 0; i < alldata.length; i++) {
        QueryDocumentSnapshot value = alldata[i];
        if (value.id != widget.userid) {
          String thisid = value.id;
          Map thisdata = value.data();
          GeoPoint thisloc = thisdata["location"];
          double thisdistance = distance(current.latitude, thisloc.latitude,
              current.longitude, thisloc.longitude);
          if (thisdistance <= 100) {
            if (!(userpeople.contains(thisid))) {
              userpeople.add(thisid);
            }
          }
        }
      }
      neighbour.doc(widget.userid).update({
        'Contacted_People': userpeople,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> initialiseMarkersAnCircles() async {
    try {
      QuerySnapshot result = await location.get();
      List alldata = result.docs;
      if (markers.length >= alldata.length) {
        markers.removeRange(0, markers.length);
        circles.removeRange(0, circles.length);
      }
      for (int i = 0; i < alldata.length; i++) {
        QueryDocumentSnapshot value = alldata[i];
        String thisid = value.id;
        Map thisdata = value.data();
        GeoPoint thisloc = thisdata["location"];
        if (thisloc != null) {
          DocumentSnapshot data = await FirebaseFirestore.instance
                .collection('UserData')
                .doc(thisid)
                .get();
            Color circleColor = Colors.blue;
            List userData = data.data()["risk"];
            if (userData.length != 0 && userData[userData.length-1] == "High Risk") {
              setState(() {
                circleColor = Colors.red;
              });
            }
            if (userData.length != 0 && userData[userData.length-1] == "Low Risk") {
              setState(() {
                circleColor = Colors.green;
              });
            }
          if (thisid == widget.userid) {
            Uint8List imageData = await getMarker();
            markers.add(Marker(
              infoWindow:
                  InfoWindow(title: "${thisloc.latitude},${thisloc.longitude}"),
              icon: BitmapDescriptor.fromBytes(imageData),
              markerId: MarkerId(thisid),
              position: LatLng(thisloc.latitude, thisloc.longitude),
              draggable: false,
              zIndex: 2,
              flat: false,
              anchor: Offset(0.5, 0.5),
            ));
            circles.add(Circle(
              circleId: CircleId(thisid),
              radius: 100,
              zIndex: 1,
              strokeColor: circleColor,
              center: LatLng(thisloc.latitude, thisloc.longitude),
              fillColor: Colors.blue.withAlpha(70),
            ));
          } else {
            markers.add(Marker(
              infoWindow:
                  InfoWindow(title: "${thisloc.latitude},${thisloc.longitude}"),
              markerId: MarkerId(thisid),
              position: LatLng(thisloc.latitude, thisloc.longitude),
              draggable: false,
              zIndex: 2,
              flat: false,
              anchor: Offset(0.5, 0.5),
            ));
            circles.add(Circle(
              circleId: CircleId(thisid),
              radius: 100,
              zIndex: 1,
              strokeColor: circleColor,
              center: LatLng(thisloc.latitude, thisloc.longitude),
              fillColor: circleColor.withAlpha(70),
            ));
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    initialiseMarkersAnCircles();
    super.initState();
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: Text(
          'Step Out',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.0437,
            color: Colors.black,
          ),
        ),
      ),
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width / 128),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 32,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: MediaQuery.of(context).size.width / 128,
                        color: Colors.black),
                  ),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: initialLocation,
                      /*markers: Set.of((marker != null) ? [marker] : markers),
                      circles: Set.of((circle != null) ? [circle] : circles),*/
                      markers: Set.of(markers),
                      circles: Set.of(circles),
                      onMapCreated: (GoogleMapController controller) {
                        _controller = controller;
                      },
                      compassEnabled: true,
                      gestureRecognizers: Set()
                        ..add(Factory<PanGestureRecognizer>(
                            () => PanGestureRecognizer()))
                        ..add(Factory<ScaleGestureRecognizer>(
                            () => ScaleGestureRecognizer()))
                        ..add(Factory<VerticalDragGestureRecognizer>(
                            () => VerticalDragGestureRecognizer()))
                        ..add(Factory<HorizontalDragGestureRecognizer>(
                            () => HorizontalDragGestureRecognizer()))
                        ..add(Factory<EagerGestureRecognizer>(
                            () => EagerGestureRecognizer()))),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 32,
                ),
                ButtonTheme(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(
                          MediaQuery.of(context).size.width / 10.666)),
                  minWidth: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height / 14,
                  buttonColor: Colors.cyan,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Back Home',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.height / 21.333,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 32,
                ),
                Divider(
                  height: MediaQuery.of(context).size.height / 128,
                  thickness: MediaQuery.of(context).size.height / 320,
                  color: Colors.blueAccent,
                  indent: MediaQuery.of(context).size.width / 10.666,
                  endIndent: MediaQuery.of(context).size.width / 10.666,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 64,
                ),
                Text(
                  'PANDEMIC',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height / 32,
                      color: Colors.red),
                ),
                Text(
                  'Alert, Detection and Tracker',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height / 32,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_searching),
        onPressed: () {
          getCurrentLocation();
        },
      ),
    );
  }
}
