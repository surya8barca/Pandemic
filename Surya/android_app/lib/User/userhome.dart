import 'package:android_app/Shared/loadingscreen.dart';
import 'package:android_app/auth/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  String name, dob, address;
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
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
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
          child: Container(),
        ),
      ),
    );
    } else {
      return Loading();
    }
  }
}
