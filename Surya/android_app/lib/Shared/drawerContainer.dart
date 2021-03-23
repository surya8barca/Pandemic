import 'package:android_app/auth/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DrawerC extends StatefulWidget {
  const DrawerC({
    Key key,
    @required this.name,
    @required this.box,
    @required this.age,
    @required this.userid,
  }) : super(key: key);

  final String name;
  final Box box;
  final int age;
  final String userid;

  @override
  _DrawerCState createState() => _DrawerCState();
}

class _DrawerCState extends State<DrawerC> {
  List emailids = [];
  Email email = Email(
    body:
        'Hello, I am a pandemic user. I have recently been in contact with u and I would like to alert you as I have been tested positive in my COVID-19 test and I would suggest you to take your test too',
    subject: 'Risk of COVID-19',
    isHTML: false,
  );

  final CollectionReference contactedPeople =
      FirebaseFirestore.instance.collection('Contacted People');
  final CollectionReference userdata =
      FirebaseFirestore.instance.collection('UserData');

  Future<List> getContacted() async {
    try {
      List contactedIDs = [];
      DocumentSnapshot result = await contactedPeople.doc(widget.userid).get();
      Map allmap = result.data();
      List alldata = allmap['Contacted_People'];
      if (alldata.length != 0) {
        for (int i = 0; i < alldata.length; i++) {
          contactedIDs.add(alldata[i]);
        }
      }
      return contactedIDs;
    } catch (e) {
      return [];
    }
  }

  Future<bool> sendEmail(List ids) async {
    try {
      List<String> emailids = [];
      for (int i = 0; i < ids.length; i++) {
        DocumentSnapshot data = await userdata.doc(ids[i]).get();
        emailids.add(data.data()['email']);
      }
      Email email = Email(        body:
            'Hello, I am a Pandemic user. I have recently been in contact with u and I would like to alert you as I have been tested positive in my COVID-19 test and I would suggest you to take your test too',
        subject: 'Risk of COVID-19',
        recipients: emailids,
        isHTML: false,
      );
      await FlutterEmailSender.send(email);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    widget.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height / 25.6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 128,
                ),
                Center(
                  child: Text(
                    widget.age.toString() + " years",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height / 25.6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
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
                              fontSize: MediaQuery.of(context).size.height / 32,
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
                                  child: SpinKitCircle(color: Colors.blue),
                                )).show();
                            await FirebaseAuth.instance.signOut();
                            if (widget.box.length != 0) {
                              await widget.box.deleteAt(0);
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
                              fontSize: MediaQuery.of(context).size.height / 32,
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
            padding: EdgeInsets.all(MediaQuery.of(context).size.width / 32),
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
          RaisedButton(
            color: Colors.red,
            onPressed: () async {
              Alert(
                  context: context,
                  style: AlertStyle(
                    backgroundColor: Colors.red,
                    isCloseButton: false,
                    isOverlayTapDismiss: false,
                  ),
                  title: "Alerting Contacted People",
                  buttons: [],
                  content: Container(
                    child: SpinKitCircle(color: Colors.black),
                  )).show();
              List contacted = await getContacted();
              if (contacted.length == 0) {
                Navigator.pop(context);
                Alert(
                  context: context,
                  style: AlertStyle(
                    backgroundColor: Colors.cyan,
                    isCloseButton: false,
                    isOverlayTapDismiss: false,
                  ),
                  title: "No contacted people",
                  desc: 'No one came in your contact in the previous few days',
                  buttons: [],
                ).show();
                await Future.delayed(Duration(seconds: 3));
                Navigator.pop(context);
              } else {
                bool statement = await sendEmail(contacted);

                if (statement == true) {
                  Navigator.pop(context);
                  Alert(
                    context: context,
                    style: AlertStyle(
                      backgroundColor: Colors.cyan,
                      isCloseButton: false,
                      isOverlayTapDismiss: false,
                    ),
                    title: "People Alerted",
                    desc:
                        'All the people who came in your contact have been alerted',
                    buttons: [],
                  ).show();
                  await Future.delayed(Duration(seconds: 3));
                  Navigator.pop(context);
                } else {
                  Navigator.pop(context);
                  Alert(
                    context: context,
                    style: AlertStyle(
                      backgroundColor: Colors.cyan,
                      isCloseButton: false,
                      isOverlayTapDismiss: false,
                    ),
                    title: "Error",
                    desc:
                        'Some Error occurred while alerting people, Please try again!',
                    buttons: [],
                  ).show();
                  await Future.delayed(Duration(seconds: 3));
                  Navigator.pop(context);
                }
              }
            },
            padding: EdgeInsets.all(MediaQuery.of(context).size.width / 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.width / 21.33),
            ),
            elevation: MediaQuery.of(context).size.height / 64,
            child: Text(
              'Alert People',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height / 21.33,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 64,
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
    );
  }
}
