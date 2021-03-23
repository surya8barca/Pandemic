import 'dart:convert';

import 'package:android_app/User/userhome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Quiz extends StatefulWidget {
  final int age;
  final String gender, userid;
  final List risk;

  Quiz({this.age, this.gender, this.risk, this.userid});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Quiz> {
  List answers = ['Yes', 'No'];
  String a1,
      a2,
      a3,
      a4,
      a5,
      a6,
      a7,
      a8,
      a9,
      a10,
      a11,
      a12,
      a13,
      a14,
      a15,
      a16,
      a17,
      a18,
      a19,
      a20;
  String q1,
      q2,
      q3,
      q4,
      q5,
      q6,
      q7,
      q8,
      q9,
      q10,
      q11,
      q12,
      q13,
      q14,
      q15,
      q16,
      q17,
      q18,
      q19,
      q20;

  bool check() {
    if (q1 == null ||
        q2 == null ||
        q3 == null ||
        q4 == null ||
        q5 == null ||
        q6 == null ||
        q7 == null ||
        q8 == null ||
        q9 == null ||
        q10 == null ||
        q11 == null ||
        q12 == null ||
        q13 == null ||
        q14 == null ||
        q15 == null ||
        q16 == null ||
        q17 == null ||
        q18 == null ||
        q19 == null ||
        q20 == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> getresult() async {
    try {
      String url =
          'https://covid-22019.herokuapp.com/predict/?Breathing+Problem=$a1&Fever=$a2&Dry+Cough=$a3&Sore+throat=$a4&Running+Nose=$a5&Asthma=$a6&Chronic+Lung+Disease=$a7&Headache=$a8&Heart+Disease=$a9&Diabetes=$a10&Hyper+Tension=$a11&Fatigue=$a12&Gastrointestinal=$a13&Abroad+travel=$a14&Contact+with+COVID+Patient=$a15&Attended+Large+Gathering=$a16&Visited+Public+Exposed+Places=$a17&Family+working+in+Public+Exposed+Places=$a18&Wearing+Masks=$a19&Sanitization+from+Market=$a20';
      Response data = await get(url);
      Map result = jsonDecode(data.body);
      List newrisk = widget.risk;
      newrisk.add(result['prediction']);
      CollectionReference fire =
          FirebaseFirestore.instance.collection('UserData');
      fire.doc(widget.userid).update({
        "risk": newrisk,
      });
    } catch (e) {
      Navigator.pop(context);
      Alert(
              context: context,
              title: 'Error',
              desc: e.toString(),
              buttons: [],
              style:
                  AlertStyle(isCloseButton: false, isOverlayTapDismiss: false))
          .show();
      await Future.delayed(Duration(seconds: 2));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: Text(
          'Quiz',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.0437,
            color: Colors.black,
          ),
        ),
      ),
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width / 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Answer the following questions',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.height / 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 64,
                ),
                Container(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width / 48),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black,
                        width: MediaQuery.of(context).size.width / 240),
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width / 16),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Do you have Breathing Problems?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: MediaQuery.of(context).size.height / 24),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 64,
                      ),
                      Container(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 64),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.blue,
                              width: MediaQuery.of(context).size.width / 160),
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width / 12.8),
                          color: Colors.white,
                        ),
                        child: DropdownButton(
                          iconEnabledColor: Colors.blue,
                          underline: Container(),
                          hint: Text(
                            'Select Any one:',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height / 25.6,
                              color: Colors.blue,
                            ),
                          ),
                          isExpanded: true,
                          items: answers.map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              child: Container(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width / 64),
                                height:
                                    MediaQuery.of(context).size.height / 10.66,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blue,
                                      width: MediaQuery.of(context).size.width /
                                          160),
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width / 32),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      value,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              42.666,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                  ],
                                ),
                              ),
                              value: value,
                            );
                          }).toList(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          onChanged: (chosen) {
                            setState(() {
                              q1 = chosen;
                            });
                            if (chosen == 'Yes') {
                              setState(() {
                                a1 = '1';
                              });
                            } else {
                              setState(() {
                                a1 = '0';
                              });
                            }
                          },
                          value: q1,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      Text(
                        "Do you have a Fever?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: MediaQuery.of(context).size.height / 24),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 64,
                      ),
                      Container(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 64),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.blue,
                              width: MediaQuery.of(context).size.width / 160),
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width / 12.8),
                          color: Colors.white,
                        ),
                        child: DropdownButton(
                          iconEnabledColor: Colors.blue,
                          underline: Container(),
                          hint: Text(
                            'Select Any one:',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height / 25.6,
                              color: Colors.blue,
                            ),
                          ),
                          isExpanded: true,
                          items: answers.map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              child: Container(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width / 64),
                                height:
                                    MediaQuery.of(context).size.height / 10.66,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blue,
                                      width: MediaQuery.of(context).size.width /
                                          160),
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width / 32),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      value,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              42.666,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                  ],
                                ),
                              ),
                              value: value,
                            );
                          }).toList(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          onChanged: (chosen) {
                            setState(() {
                              q2 = chosen;
                            });
                            if (chosen == 'Yes') {
                              setState(() {
                                a2 = '1';
                              });
                            } else {
                              setState(() {
                                a2 = '0';
                              });
                            }
                          },
                          value: q2,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      Text(
                        "Do you have Dry Cough?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: MediaQuery.of(context).size.height / 24),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 64,
                      ),
                      Container(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 64),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.blue,
                              width: MediaQuery.of(context).size.width / 160),
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width / 12.8),
                          color: Colors.white,
                        ),
                        child: DropdownButton(
                          iconEnabledColor: Colors.blue,
                          underline: Container(),
                          hint: Text(
                            'Select Any one:',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height / 25.6,
                              color: Colors.blue,
                            ),
                          ),
                          isExpanded: true,
                          items: answers.map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              child: Container(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width / 64),
                                height:
                                    MediaQuery.of(context).size.height / 10.66,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blue,
                                      width: MediaQuery.of(context).size.width /
                                          160),
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width / 32),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      value,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              42.666,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                  ],
                                ),
                              ),
                              value: value,
                            );
                          }).toList(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          onChanged: (chosen) {
                            setState(() {
                              q3 = chosen;
                            });
                            if (chosen == 'Yes') {
                              setState(() {
                                a3 = '1';
                              });
                            } else {
                              setState(() {
                                a3 = '0';
                              });
                            }
                          },
                          value: q3,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      Text(
                        "Do you have Sore throat?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: MediaQuery.of(context).size.height / 24),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 64,
                      ),
                      Container(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 64),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.blue,
                              width: MediaQuery.of(context).size.width / 160),
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width / 12.8),
                          color: Colors.white,
                        ),
                        child: DropdownButton(
                          iconEnabledColor: Colors.blue,
                          underline: Container(),
                          hint: Text(
                            'Select Any one:',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height / 25.6,
                              color: Colors.blue,
                            ),
                          ),
                          isExpanded: true,
                          items: answers.map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              child: Container(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width / 64),
                                height:
                                    MediaQuery.of(context).size.height / 10.66,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blue,
                                      width: MediaQuery.of(context).size.width /
                                          160),
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width / 32),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      value,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              42.666,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                  ],
                                ),
                              ),
                              value: value,
                            );
                          }).toList(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          onChanged: (chosen) {
                            setState(() {
                              q4 = chosen;
                            });
                            if (chosen == 'Yes') {
                              setState(() {
                                a4 = '1';
                              });
                            } else {
                              setState(() {
                                a4 = '0';
                              });
                            }
                          },
                          value: q4,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      Text(
                        "Do you have a Running Nose?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: MediaQuery.of(context).size.height / 24),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 64,
                      ),
                      Container(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 64),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.blue,
                              width: MediaQuery.of(context).size.width / 160),
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width / 12.8),
                          color: Colors.white,
                        ),
                        child: DropdownButton(
                          iconEnabledColor: Colors.blue,
                          underline: Container(),
                          hint: Text(
                            'Select Any one:',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height / 25.6,
                              color: Colors.blue,
                            ),
                          ),
                          isExpanded: true,
                          items: answers.map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              child: Container(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width / 64),
                                height:
                                    MediaQuery.of(context).size.height / 10.66,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blue,
                                      width: MediaQuery.of(context).size.width /
                                          160),
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width / 32),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      value,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              42.666,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                  ],
                                ),
                              ),
                              value: value,
                            );
                          }).toList(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          onChanged: (chosen) {
                            setState(() {
                              q5 = chosen;
                            });
                            if (chosen == 'Yes') {
                              setState(() {
                                a5 = '1';
                              });
                            } else {
                              setState(() {
                                a5 = '0';
                              });
                            }
                          },
                          value: q5,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      Text(
                        "Do you have Asthma?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: MediaQuery.of(context).size.height / 24),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 64,
                      ),
                      Container(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 64),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.blue,
                              width: MediaQuery.of(context).size.width / 160),
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width / 12.8),
                          color: Colors.white,
                        ),
                        child: DropdownButton(
                          iconEnabledColor: Colors.blue,
                          underline: Container(),
                          hint: Text(
                            'Select Any one:',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height / 25.6,
                              color: Colors.blue,
                            ),
                          ),
                          isExpanded: true,
                          items: answers.map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              child: Container(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width / 64),
                                height:
                                    MediaQuery.of(context).size.height / 10.66,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blue,
                                      width: MediaQuery.of(context).size.width /
                                          160),
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width / 32),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      value,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              42.666,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                  ],
                                ),
                              ),
                              value: value,
                            );
                          }).toList(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          onChanged: (chosen) {
                            setState(() {
                              q6 = chosen;
                            });
                            if (chosen == 'Yes') {
                              setState(() {
                                a6 = '1';
                              });
                            } else {
                              setState(() {
                                a6 = '0';
                              });
                            }
                          },
                          value: q6,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      Text(
                        "Do you have any chronic lung diseases?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: MediaQuery.of(context).size.height / 24),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 64,
                      ),
                      Container(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 64),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.blue,
                              width: MediaQuery.of(context).size.width / 160),
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width / 12.8),
                          color: Colors.white,
                        ),
                        child: DropdownButton(
                          iconEnabledColor: Colors.blue,
                          underline: Container(),
                          hint: Text(
                            'Select Any one:',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height / 25.6,
                              color: Colors.blue,
                            ),
                          ),
                          isExpanded: true,
                          items: answers.map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              child: Container(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width / 64),
                                height:
                                    MediaQuery.of(context).size.height / 10.66,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blue,
                                      width: MediaQuery.of(context).size.width /
                                          160),
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width / 32),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      value,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              42.666,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                  ],
                                ),
                              ),
                              value: value,
                            );
                          }).toList(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          onChanged: (chosen) {
                            setState(() {
                              q7 = chosen;
                            });
                            if (chosen == 'Yes') {
                              setState(() {
                                a7 = '1';
                              });
                            } else {
                              setState(() {
                                a7 = '0';
                              });
                            }
                          },
                          value: q7,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      Text(
                        "Have you experienced headaches recently?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: MediaQuery.of(context).size.height / 24),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 64,
                      ),
                      Container(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 64),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.blue,
                              width: MediaQuery.of(context).size.width / 160),
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width / 12.8),
                          color: Colors.white,
                        ),
                        child: DropdownButton(
                          iconEnabledColor: Colors.blue,
                          underline: Container(),
                          hint: Text(
                            'Select Any one:',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height / 25.6,
                              color: Colors.blue,
                            ),
                          ),
                          isExpanded: true,
                          items: answers.map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              child: Container(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width / 64),
                                height:
                                    MediaQuery.of(context).size.height / 10.66,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blue,
                                      width: MediaQuery.of(context).size.width /
                                          160),
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width / 32),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      value,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              42.666,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                  ],
                                ),
                              ),
                              value: value,
                            );
                          }).toList(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          onChanged: (chosen) {
                            setState(() {
                              q8 = chosen;
                            });
                            if (chosen == 'Yes') {
                              setState(() {
                                a8 = '1';
                              });
                            } else {
                              setState(() {
                                a8 = '0';
                              });
                            }
                          },
                          value: q8,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      Text(
                        "Do you have a heart disease?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: MediaQuery.of(context).size.height / 24),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 64,
                      ),
                      Container(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 64),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.blue,
                              width: MediaQuery.of(context).size.width / 160),
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width / 12.8),
                          color: Colors.white,
                        ),
                        child: DropdownButton(
                          iconEnabledColor: Colors.blue,
                          underline: Container(),
                          hint: Text(
                            'Select Any one:',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height / 25.6,
                              color: Colors.blue,
                            ),
                          ),
                          isExpanded: true,
                          items: answers.map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              child: Container(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width / 64),
                                height:
                                    MediaQuery.of(context).size.height / 10.66,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blue,
                                      width: MediaQuery.of(context).size.width /
                                          160),
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width / 32),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      value,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              42.666,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                  ],
                                ),
                              ),
                              value: value,
                            );
                          }).toList(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          onChanged: (chosen) {
                            setState(() {
                              q9 = chosen;
                            });
                            if (chosen == 'Yes') {
                              setState(() {
                                a9 = '1';
                              });
                            } else {
                              setState(() {
                                a9 = '0';
                              });
                            }
                          },
                          value: q9,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      Text(
                        "Do you have Diabetes?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: MediaQuery.of(context).size.height / 24),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 64,
                      ),
                      Container(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 64),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.blue,
                              width: MediaQuery.of(context).size.width / 160),
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width / 12.8),
                          color: Colors.white,
                        ),
                        child: DropdownButton(
                          iconEnabledColor: Colors.blue,
                          underline: Container(),
                          hint: Text(
                            'Select Any one:',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height / 25.6,
                              color: Colors.blue,
                            ),
                          ),
                          isExpanded: true,
                          items: answers.map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              child: Container(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width / 64),
                                height:
                                    MediaQuery.of(context).size.height / 10.66,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blue,
                                      width: MediaQuery.of(context).size.width /
                                          160),
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width / 32),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      value,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              42.666,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                  ],
                                ),
                              ),
                              value: value,
                            );
                          }).toList(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          onChanged: (chosen) {
                            setState(() {
                              q10 = chosen;
                            });
                            if (chosen == 'Yes') {
                              setState(() {
                                a10 = '1';
                              });
                            } else {
                              setState(() {
                                a10 = '0';
                              });
                            }
                          },
                          value: q10,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      Text(
                        "Do you see symtoms of Hyper Tension like chest pain, blood in urine, high blood pressure?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: MediaQuery.of(context).size.height / 24),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 64,
                      ),
                      Container(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 64),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.blue,
                              width: MediaQuery.of(context).size.width / 160),
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width / 12.8),
                          color: Colors.white,
                        ),
                        child: DropdownButton(
                          iconEnabledColor: Colors.blue,
                          underline: Container(),
                          hint: Text(
                            'Select Any one:',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height / 25.6,
                              color: Colors.blue,
                            ),
                          ),
                          isExpanded: true,
                          items: answers.map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              child: Container(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width / 64),
                                height:
                                    MediaQuery.of(context).size.height / 10.66,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blue,
                                      width: MediaQuery.of(context).size.width /
                                          160),
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width / 32),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      value,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              42.666,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                  ],
                                ),
                              ),
                              value: value,
                            );
                          }).toList(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          onChanged: (chosen) {
                            setState(() {
                              q11 = chosen;
                            });
                            if (chosen == 'Yes') {
                              setState(() {
                                a11 = '1';
                              });
                            } else {
                              setState(() {
                                a11 = '0';
                              });
                            }
                          },
                          value: q11,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      Text(
                        "Have you recently felt fatigue?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: MediaQuery.of(context).size.height / 24),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 64,
                      ),
                      Container(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 64),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.blue,
                              width: MediaQuery.of(context).size.width / 160),
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width / 12.8),
                          color: Colors.white,
                        ),
                        child: DropdownButton(
                          iconEnabledColor: Colors.blue,
                          underline: Container(),
                          hint: Text(
                            'Select Any one:',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height / 25.6,
                              color: Colors.blue,
                            ),
                          ),
                          isExpanded: true,
                          items: answers.map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              child: Container(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width / 64),
                                height:
                                    MediaQuery.of(context).size.height / 10.66,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blue,
                                      width: MediaQuery.of(context).size.width /
                                          160),
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width / 32),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      value,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              42.666,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                  ],
                                ),
                              ),
                              value: value,
                            );
                          }).toList(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          onChanged: (chosen) {
                            setState(() {
                              q12 = chosen;
                            });
                            if (chosen == 'Yes') {
                              setState(() {
                                a12 = '1';
                              });
                            } else {
                              setState(() {
                                a12 = '0';
                              });
                            }
                          },
                          value: q12,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      Text(
                        "Do you have any Gastrointestinal diseases?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: MediaQuery.of(context).size.height / 24),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 64,
                      ),
                      Container(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 64),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.blue,
                              width: MediaQuery.of(context).size.width / 160),
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width / 12.8),
                          color: Colors.white,
                        ),
                        child: DropdownButton(
                          iconEnabledColor: Colors.blue,
                          underline: Container(),
                          hint: Text(
                            'Select Any one:',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height / 25.6,
                              color: Colors.blue,
                            ),
                          ),
                          isExpanded: true,
                          items: answers.map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              child: Container(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width / 64),
                                height:
                                    MediaQuery.of(context).size.height / 10.66,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blue,
                                      width: MediaQuery.of(context).size.width /
                                          160),
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width / 32),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      value,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              42.666,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                  ],
                                ),
                              ),
                              value: value,
                            );
                          }).toList(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          onChanged: (chosen) {
                            setState(() {
                              q13 = chosen;
                            });
                            if (chosen == 'Yes') {
                              setState(() {
                                a13 = '1';
                              });
                            } else {
                              setState(() {
                                a13 = '0';
                              });
                            }
                          },
                          value: q13,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      Text(
                        "Have you recently come in contact with COVID Patient?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: MediaQuery.of(context).size.height / 24),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 64,
                      ),
                      Container(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 64),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.blue,
                              width: MediaQuery.of(context).size.width / 160),
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width / 12.8),
                          color: Colors.white,
                        ),
                        child: DropdownButton(
                          iconEnabledColor: Colors.blue,
                          underline: Container(),
                          hint: Text(
                            'Select Any one:',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height / 25.6,
                              color: Colors.blue,
                            ),
                          ),
                          isExpanded: true,
                          items: answers.map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              child: Container(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width / 64),
                                height:
                                    MediaQuery.of(context).size.height / 10.66,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blue,
                                      width: MediaQuery.of(context).size.width /
                                          160),
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width / 32),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      value,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              42.666,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                  ],
                                ),
                              ),
                              value: value,
                            );
                          }).toList(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          onChanged: (chosen) {
                            setState(() {
                              q14 = chosen;
                            });
                            if (chosen == 'Yes') {
                              setState(() {
                                a14 = '1';
                              });
                            } else {
                              setState(() {
                                a14 = '0';
                              });
                            }
                          },
                          value: q14,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      Text(
                        "Have you travelled abroad?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: MediaQuery.of(context).size.height / 24),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 64,
                      ),
                      Container(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 64),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.blue,
                              width: MediaQuery.of(context).size.width / 160),
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width / 12.8),
                          color: Colors.white,
                        ),
                        child: DropdownButton(
                          iconEnabledColor: Colors.blue,
                          underline: Container(),
                          hint: Text(
                            'Select Any one:',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height / 25.6,
                              color: Colors.blue,
                            ),
                          ),
                          isExpanded: true,
                          items: answers.map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              child: Container(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width / 64),
                                height:
                                    MediaQuery.of(context).size.height / 10.66,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blue,
                                      width: MediaQuery.of(context).size.width /
                                          160),
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width / 32),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      value,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              42.666,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                  ],
                                ),
                              ),
                              value: value,
                            );
                          }).toList(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          onChanged: (chosen) {
                            setState(() {
                              q15 = chosen;
                            });
                            if (chosen == 'Yes') {
                              setState(() {
                                a15 = '1';
                              });
                            } else {
                              setState(() {
                                a15 = '0';
                              });
                            }
                          },
                          value: q15,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      Text(
                        "Have you attended any large gathering recently?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: MediaQuery.of(context).size.height / 24),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 64,
                      ),
                      Container(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 64),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.blue,
                              width: MediaQuery.of(context).size.width / 160),
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width / 12.8),
                          color: Colors.white,
                        ),
                        child: DropdownButton(
                          iconEnabledColor: Colors.blue,
                          underline: Container(),
                          hint: Text(
                            'Select Any one:',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height / 25.6,
                              color: Colors.blue,
                            ),
                          ),
                          isExpanded: true,
                          items: answers.map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              child: Container(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width / 64),
                                height:
                                    MediaQuery.of(context).size.height / 10.66,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blue,
                                      width: MediaQuery.of(context).size.width /
                                          160),
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width / 32),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      value,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              42.666,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                  ],
                                ),
                              ),
                              value: value,
                            );
                          }).toList(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          onChanged: (chosen) {
                            setState(() {
                              q16 = chosen;
                            });
                            if (chosen == 'Yes') {
                              setState(() {
                                a16 = '1';
                              });
                            } else {
                              setState(() {
                                a16 = '0';
                              });
                            }
                          },
                          value: q16,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      Text(
                        "Have you visited any exposed places recently?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: MediaQuery.of(context).size.height / 24),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 64,
                      ),
                      Container(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 64),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.blue,
                              width: MediaQuery.of(context).size.width / 160),
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width / 12.8),
                          color: Colors.white,
                        ),
                        child: DropdownButton(
                          iconEnabledColor: Colors.blue,
                          underline: Container(),
                          hint: Text(
                            'Select Any one:',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height / 25.6,
                              color: Colors.blue,
                            ),
                          ),
                          isExpanded: true,
                          items: answers.map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              child: Container(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width / 64),
                                height:
                                    MediaQuery.of(context).size.height / 10.66,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blue,
                                      width: MediaQuery.of(context).size.width /
                                          160),
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width / 32),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      value,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              42.666,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                  ],
                                ),
                              ),
                              value: value,
                            );
                          }).toList(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          onChanged: (chosen) {
                            setState(() {
                              q17 = chosen;
                            });
                            if (chosen == 'Yes') {
                              setState(() {
                                a17 = '1';
                              });
                            } else {
                              setState(() {
                                a17 = '0';
                              });
                            }
                          },
                          value: q17,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      Text(
                        "Does any family member who lives with you works in an exposed place?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: MediaQuery.of(context).size.height / 24),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 64,
                      ),
                      Container(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 64),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.blue,
                              width: MediaQuery.of(context).size.width / 160),
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width / 12.8),
                          color: Colors.white,
                        ),
                        child: DropdownButton(
                          iconEnabledColor: Colors.blue,
                          underline: Container(),
                          hint: Text(
                            'Select Any one:',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height / 25.6,
                              color: Colors.blue,
                            ),
                          ),
                          isExpanded: true,
                          items: answers.map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              child: Container(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width / 64),
                                height:
                                    MediaQuery.of(context).size.height / 10.66,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blue,
                                      width: MediaQuery.of(context).size.width /
                                          160),
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width / 32),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      value,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              42.666,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                  ],
                                ),
                              ),
                              value: value,
                            );
                          }).toList(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          onChanged: (chosen) {
                            setState(() {
                              q18 = chosen;
                            });
                            if (chosen == 'Yes') {
                              setState(() {
                                a18 = '1';
                              });
                            } else {
                              setState(() {
                                a18 = '0';
                              });
                            }
                          },
                          value: q18,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      Text(
                        "Were you always wereing masks while going outside?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: MediaQuery.of(context).size.height / 24),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 64,
                      ),
                      Container(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 64),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.blue,
                              width: MediaQuery.of(context).size.width / 160),
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width / 12.8),
                          color: Colors.white,
                        ),
                        child: DropdownButton(
                          iconEnabledColor: Colors.blue,
                          underline: Container(),
                          hint: Text(
                            'Select Any one:',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height / 25.6,
                              color: Colors.blue,
                            ),
                          ),
                          isExpanded: true,
                          items: answers.map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              child: Container(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width / 64),
                                height:
                                    MediaQuery.of(context).size.height / 10.66,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blue,
                                      width: MediaQuery.of(context).size.width /
                                          160),
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width / 32),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      value,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              42.666,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                  ],
                                ),
                              ),
                              value: value,
                            );
                          }).toList(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          onChanged: (chosen) {
                            setState(() {
                              q19 = chosen;
                            });
                            if (chosen == 'Yes') {
                              setState(() {
                                a19 = '1';
                              });
                            } else {
                              setState(() {
                                a19 = '0';
                              });
                            }
                          },
                          value: q19,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      Text(
                        "Did you visit take proper steps to sanitize yourself after going outside?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: MediaQuery.of(context).size.height / 24),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 64,
                      ),
                      Container(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 64),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.blue,
                              width: MediaQuery.of(context).size.width / 160),
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width / 12.8),
                          color: Colors.white,
                        ),
                        child: DropdownButton(
                          iconEnabledColor: Colors.blue,
                          underline: Container(),
                          hint: Text(
                            'Select Any one:',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height / 25.6,
                              color: Colors.blue,
                            ),
                          ),
                          isExpanded: true,
                          items: answers.map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              child: Container(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width / 64),
                                height:
                                    MediaQuery.of(context).size.height / 10.66,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blue,
                                      width: MediaQuery.of(context).size.width /
                                          160),
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width / 32),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      value,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              42.666,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                  ],
                                ),
                              ),
                              value: value,
                            );
                          }).toList(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          onChanged: (chosen) {
                            setState(() {
                              q20 = chosen;
                            });
                            if (chosen == 'Yes') {
                              setState(() {
                                a20 = '1';
                              });
                            } else {
                              setState(() {
                                a20 = '0';
                              });
                            }
                          },
                          value: q20,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ButtonTheme(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width /
                                        10.666)),
                            minWidth: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.height / 10.666,
                            buttonColor: Colors.cyan,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (check()) {
                                  Alert(
                                          context: context,
                                          title: 'Please Wait',
                                          desc: 'Generating your Report..',
                                          buttons: [],
                                          content: Container(
                                            child: SpinKitCircle(
                                                color: Colors.blue),
                                          ),
                                          style: AlertStyle(
                                              isCloseButton: false,
                                              isOverlayTapDismiss: false))
                                      .show();
                                  await getresult();
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UserHome(widget.userid)),
                                      (route) => false);
                                } else {
                                  Alert(
                                          context: context,
                                          title: 'Invalid Input',
                                          desc: 'All fields are required',
                                          buttons: [],
                                          style: AlertStyle(
                                              isCloseButton: false,
                                              isOverlayTapDismiss: false))
                                      .show();
                                  await Future.delayed(Duration(seconds: 2));
                                  Navigator.pop(context);
                                }
                              },
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: MediaQuery.of(context).size.height /
                                      21.333,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 16,
                          ),
                          ButtonTheme(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width /
                                        10.666)),
                            minWidth: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.height / 10.666,
                            buttonColor: Colors.cyan,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: MediaQuery.of(context).size.height /
                                      21.333,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
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
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
