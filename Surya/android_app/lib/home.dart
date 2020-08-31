import 'package:android_app/Shared/loadingscreen.dart';
import 'package:flutter/material.dart';

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
    } else { //auth page if no user already logged in
      return SafeArea(
              child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            centerTitle: true,
            title: Text(
              'Pandemic',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.08,
                color: Colors.black,
              ),
            ),
          ),
          body: Builder(
            builder: (context) => SingleChildScrollView(
              child: Container(),
            ),
          ),
        ),
      );
    }
  }
}
