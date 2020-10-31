import 'package:android_app/Shared/loadingscreen.dart';
import 'package:android_app/User/userhome.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'auth/login.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool start = false;
  final box = Hive.box('currentuser');
  //device height = 640
  //device width  =320

  Future<void> splash() async {
    await Future.delayed(Duration(seconds: 5));
    setState(() {
      start = true;
    });
  }

  @override
  void initState() {
    splash();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (start == false) {
      return Loading();
    } else {
      if (box.length == 0) {
        return Login();
      } else {
        return UserHome(box.getAt(0));
      }
      //auth page if no user already logged in

    }
  }
}
