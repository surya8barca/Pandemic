import 'package:android_app/Shared/drawerContainer.dart';
import 'package:android_app/Shared/loadingscreen.dart';
import 'package:android_app/User/quiz/quiz.dart';
import 'package:android_app/User/stepOut/map.dart';
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
  String name, dob, address, riskDisplay, gender;
  int mobno, aadhar, age;
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
        age = data.data()['age'];
        gender = data.data()['gender'];
        dob = data.data()['date_of_birth'];
        address = data.data()['final_address'];
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
          riskDisplay = 'Your latest COVID-19 Risk Percentage: ' +
              risk[-1].toString() +
              '\nTake the quiz for latest report';
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
          child: DrawerC(
            name: name,
            box: box,
            age: age,
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
              padding: EdgeInsets.all(MediaQuery.of(context).size.width / 32),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/back.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 5),
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
                            fontSize: MediaQuery.of(context).size.height / 28,
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
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Quiz(
                                            age: age,
                                            gender: gender,
                                          )));
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MapHome(name: name)));
                            },
                            child: Text(
                              'Step Out',
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
