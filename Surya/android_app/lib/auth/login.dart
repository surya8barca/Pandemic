import 'package:android_app/User/userhome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'register.dart';

class Login extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Login> {
  //variables
  bool hidepassword = true, rememberme = false;
  String email, password, userid, fEmail;

  final box = Hive.box('currentuser');

  Future<bool> login() async {
    try {
      UserCredential result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      setState(() {
        userid = result.user.uid;
      });
      if (rememberme) {
        await box.add(userid);
      }
      return true;
    } catch (e) {
      Navigator.pop(context);
      Alert(
          context: context,
          title: 'Login Error',
          desc: e.toString(),
          style: AlertStyle(isCloseButton: false, isOverlayTapDismiss: false),
          buttons: []).show();
      await Future.delayed(Duration(seconds: 3));
      if (box.length != 0) {
        box.deleteAt(0);
      }
      Navigator.pop(context);
      return false;
    }
  }

  Future<bool> sendPasswordChangeEmail() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: fEmail);
      return true;
    } catch (e) {
      Alert(
              context: context,
              title: 'Error',
              desc: e.toString(),
              buttons: [],
              style: AlertStyle(
                  backgroundColor: Colors.cyan,
                  isCloseButton: false,
                  isOverlayTapDismiss: false))
          .show();
      await Future.delayed(Duration(seconds: 5));
      Navigator.pop(context);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var fieldDecoration = InputDecoration(
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(MediaQuery.of(context).size.width / 12.8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: MediaQuery.of(context).size.width / 160,
          ),
          borderRadius:
              BorderRadius.circular(MediaQuery.of(context).size.width / 12.8),
        ),
        labelStyle: TextStyle(
          color: Colors.lightBlue,
          fontSize: MediaQuery.of(context).size.height / 25.6,
        ));
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
          title: Text(
            'Login',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.0437,
              color: Colors.black,
            ),
          ),
        ),
        body: Builder(
          builder: (context) => SingleChildScrollView(
            child: Container(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width / 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Enter your login details',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        decoration:
                            fieldDecoration.copyWith(labelText: 'Email Id'),
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: MediaQuery.of(context).size.height / 32),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              email = value;
                            });
                          }
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.done,
                        obscureText: hidepassword,
                        decoration: fieldDecoration.copyWith(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: Colors.blue,
                            ),
                            onPressed: () async {
                              setState(() {
                                hidepassword = false;
                              });
                              await Future.delayed(Duration(seconds: 3));
                              setState(() {
                                hidepassword = true;
                              });
                            },
                          ),
                        ),
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: MediaQuery.of(context).size.height / 32),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              password = value;
                            });
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Checkbox(
                            value: rememberme,
                            onChanged: (value) {
                              setState(() {
                                rememberme = value;
                              });
                            },
                          ),
                          Text(
                            'Remember me',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: MediaQuery.of(context).size.height / 32,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 64),
                      ButtonTheme(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(
                                MediaQuery.of(context).size.width / 10.666)),
                        minWidth: MediaQuery.of(context).size.width / 2.1333,
                        height: MediaQuery.of(context).size.height / 10.666,
                        buttonColor: Colors.cyan,
                        child: ElevatedButton(
                          onPressed: () async {
                            Alert(
                                context: context,
                                style: AlertStyle(
                                  backgroundColor: Colors.white,
                                  isCloseButton: false,
                                  isOverlayTapDismiss: false,
                                ),
                                title: "Please wait",
                                desc: "Loggin user in...",
                                buttons: [],
                                content: Container(
                                  child: SpinKitCircle(color: Colors.blue),
                                )).show();
                            bool result = await login();
                            if (result) {
                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UserHome(userid),
                                  ));
                            }
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.height / 21.333,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 64,
                      ),
                      InkWell(
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            fontSize: MediaQuery.of(context).size.height / 32,
                          ),
                        ),
                        onTap: () {
                          Alert(
                            title: 'Forgot Password',
                            context: context,
                            buttons: [],
                            style: AlertStyle(
                                isCloseButton: false,
                                isOverlayTapDismiss: false,
                                backgroundColor: Colors.transparent,
                                titleStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.height / 32,
                                )),
                            content: Container(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.height / 128),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.lightBlue,
                                  width:
                                      MediaQuery.of(context).size.width / 256,
                                ),
                                borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.height / 64,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        128,
                                  ),
                                  Text(
                                    'Enter your Email Address',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      decoration: TextDecoration.underline,
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              32,
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 32,
                                  ),
                                  TextFormField(
                                    textInputAction: TextInputAction.done,
                                    decoration: fieldDecoration.copyWith(
                                        labelText: 'Email Id'),
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                32),
                                    onChanged: (value) {
                                      if (value != null) {
                                        setState(() {
                                          fEmail = value;
                                        });
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 32,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      ButtonTheme(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    32)),
                                        buttonColor: Colors.lightBlueAccent,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'Cancel',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  32,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      ButtonTheme(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        buttonColor: Colors.lightBlueAccent,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            if (fEmail != null) {
                                              bool status =
                                                  await sendPasswordChangeEmail();
                                              if (status) {
                                                Alert(
                                                        context: context,
                                                        title: 'Email Sent',
                                                        desc:
                                                            'A link has been sent on $fEmail to reset your password',
                                                        buttons: [],
                                                        style: AlertStyle(
                                                            backgroundColor:
                                                                Colors.cyan,
                                                            isCloseButton:
                                                                false,
                                                            isOverlayTapDismiss:
                                                                false))
                                                    .show();
                                                await Future.delayed(
                                                    Duration(seconds: 5));
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              } else {
                                                Navigator.pop(context);
                                              }
                                            } else {
                                              Alert(
                                                      context: context,
                                                      title: 'Invalid Input',
                                                      desc:
                                                          'All inputs are required and in correct format',
                                                      buttons: [],
                                                      style: AlertStyle(
                                                          backgroundColor:
                                                              Colors.cyan,
                                                          isCloseButton: false,
                                                          isOverlayTapDismiss:
                                                              false))
                                                  .show();
                                              await Future.delayed(
                                                  Duration(seconds: 3));
                                              Navigator.pop(context);
                                            }
                                          },
                                          child: Text(
                                            'Submit',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  32,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ).show();
                        },
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
                        'Still not a User?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height / 32,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 64,
                      ),
                      ButtonTheme(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(
                                MediaQuery.of(context).size.width / 10.666)),
                        minWidth: MediaQuery.of(context).size.width / 2.1333,
                        height: MediaQuery.of(context).size.height / 10.666,
                        buttonColor: Colors.blue,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Register(),
                                ));
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.height / 21.333,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 64,
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
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
