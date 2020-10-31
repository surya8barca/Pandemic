import 'package:android_app/Shared/loadingscreen.dart';
import 'package:android_app/auth/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class UserHome extends StatefulWidget {
  final String userid;
  UserHome(this.userid);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<UserHome> {
  final box = Hive.box('currentuser');
  String name, dob, address, riskDisplay;
  int mobno, aadhar;
  List risk;
  bool ready = false;

  Future<void> getdata() async {
    try {
      DocumentSnapshot data = await FirebaseFirestore.instance
          .collection('UserData')
          .doc(widget.userid)
          .get();
      setState(() {
        name = data.data()['name'];
        dob = data.data()['date_of_birth'];
        address = data.data()['address'];
        mobno = data.data()['mobile_no'];
        aadhar = data.data()['aadhar'];
        risk = data.data()['risk'];
        ready = true;
      });
      if (risk.length == 0) {
        setState(() {
          riskDisplay = 'You have not taken the quiz\nPlease take the quiz';
        });
      } else {
        setState(() {
          riskDisplay =
              'Your latest COVID-19 Risk Percentage: ' + risk[-1].toString()+'\nTake the quiz for latest report';
        });
      }
    } catch (e) {
      Alert(
              context: context,
              title: 'Database Error',
              desc: e.message,
              buttons: [],
              style:
                  AlertStyle(isCloseButton: false, isOverlayTapDismiss: false))
          .show();
      await Future.delayed(Duration(seconds: 3));
      Navigator.pop(context);
      Alert(
              context: context,
              title: 'Loggin Out User',
              desc: 'Try again...',
              buttons: [],
              content: Container(
                child: SpinKitCircle(color: Colors.blue),
              ),
              style:
                  AlertStyle(isCloseButton: false, isOverlayTapDismiss: false))
          .show();
      if (box.length != 0) {
        await box.deleteAt(0);
      }
      await Future.delayed(Duration(seconds: 3));
      Navigator.pop(context);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ));
    }
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    if (ready) {
      return Scaffold(
        drawer: Drawer(
          child: Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width / 32),
            color: Colors.cyan,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 25.6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  color: Colors.black,
                  thickness: MediaQuery.of(context).size.width / 106.66,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 128,
                ),
                RaisedButton(
                  onPressed: () {
                    Alert(
                      context: context,
                      style: AlertStyle(
                        backgroundColor: Colors.cyan,
                        isCloseButton: false,
                        isOverlayTapDismiss: false,
                      ),
                      title: "Logout",
                      desc: "Are you sure you want to logout?",
                      buttons: [],
                      content: Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 21.333),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            ButtonTheme(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.height / 32)),
                              buttonColor: Colors.black,
                              child: RaisedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'No',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            ButtonTheme(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              buttonColor: Colors.black,
                              child: RaisedButton(
                                onPressed: () async {
                                  Alert(
                                      context: context,
                                      style: AlertStyle(
                                        backgroundColor: Colors.white,
                                        isCloseButton: false,
                                        isOverlayTapDismiss: false,
                                      ),
                                      title: "Signing Out...",
                                      buttons: [],
                                      content: Container(
                                        child:
                                            SpinKitCircle(color: Colors.blue),
                                      )).show();
                                  await FirebaseAuth.instance.signOut();
                                  if (box.length != 0) {
                                    await box.deleteAt(0);
                                  }
                                  await Future.delayed(Duration(seconds: 2));
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Login(),
                                      ),
                                      (route) => false);
                                },
                                child: Text(
                                  'Yes',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ).show();
                  },
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width / 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width / 21.33),
                  ),
                  elevation: MediaQuery.of(context).size.height / 64,
                  child: Text(
                    'Sign Out',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height / 21.33,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      Divider(
                        height: MediaQuery.of(context).size.height / 128,
                        thickness: MediaQuery.of(context).size.height / 320,
                        color: Colors.black,
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
                          color: Colors.black,
                        ),
                      ),
              ],
            ),
          ),
        ),

        appBar: AppBar(
          backgroundColor: Colors.cyan,
          centerTitle: true,
          title: Text(
            'Home',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.0437,
              color: Colors.black,
            ),
          ),
        ),
        body: Builder(
          builder: (context) => SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(MediaQuery.of(context).size.width/32),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/back.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height/5),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          riskDisplay,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.yellow,
                            fontSize: MediaQuery.of(context).size.height/28,
                            fontWeight: FontWeight.bold,
                          ),
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
                        onPressed: () async {
                        },
                        child: Text(
                          'Quiz',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize:
                                MediaQuery.of(context).size.height / 21.333,
                          ),
                        ),
                      ),
                    ),
                      ],
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
                          color: Colors.yellow,
                        ),
                      ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Loading();
    }
  }
}
