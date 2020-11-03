import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'PANDEMIC',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height / 19,
                    color: Colors.red),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 64),
              Text(
                'Alert, Detection and Tracker',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.height / 20,
                  color: Colors.blue,
                ),
              ),
              SpinKitPumpingHeart(
                color: Colors.red,
                size: MediaQuery.of(context).size.height / 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
