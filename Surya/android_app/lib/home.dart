import 'package:android_app/Shared/loadingscreen.dart';
import 'package:flutter/material.dart';

import 'Hive/auth/login.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool start = false;
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
      //auth page if no user already logged in
      return Login();
    }
  }
}
