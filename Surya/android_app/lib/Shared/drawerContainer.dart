import 'package:android_app/auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DrawerC extends StatelessWidget {
  const DrawerC({
    Key key,
    @required this.name,
    @required this.box,
    @required this.age,
  }) : super(key: key);

  final String name;
  final Box box;
  final int age;

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
                    name,
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
                    age.toString() + " years",
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
