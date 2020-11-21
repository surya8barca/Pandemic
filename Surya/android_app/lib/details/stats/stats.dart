import 'dart:convert';

import 'package:android_app/Shared/loadingscreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Stats extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Stats> {
  bool loading = true, search = true, result = false;
  Map info;
  Map global;
  Map india;
  Map stateData = {'confirmed': 0, 'recovered': 0, 'deaths': 0};
  Map otherCountry = {
    'TotalConfirmed': 0,
    'TotalRecovered': 0,
    'TotalDeaths': 0
  };
  String country, state;
  List countries = [];
  List states = [];
  List statesData = [];

  void countrydata() {
    List all = info['Countries'];
    for (int i = 0; i < all.length; i++) {
      if (all[i]['Country'] == country) {
        setState(() {
          otherCountry = all[i];
        });
        break;
      }
    }
  }

  void statedata() {
    for (int i = 0; i < statesData.length; i++) {
      if (statesData[i]['state'] == state) {
        setState(() {
          stateData = statesData[i];
        });
      }
    }
  }

  Future<void> getdata() async {
    try {
      Response result = await get("https://api.covid19api.com/summary");
      Map output = jsonDecode(result.body);
      setState(() {
        info = output;
      });
      List all = info['Countries'];
      for (int i = 0; i < all.length; i++) {
        countries.add(all[i]['Country']);
        if (all[i]['Country'] == 'India') {
          setState(() {
            india = all[i];
          });
        }
      }
      setState(() {
        global = info['Global'];
      });
      Response result2 =
          await get("https://covid-19india-api.herokuapp.com/v2.0/state_data");
      dynamic data = jsonDecode(result2.body);
      setState(() {
        statesData = data[1]['state_data'];
      });
      for (int i = 0; i < statesData.length; i++) {
        states.add(statesData[i]['state']);
      }
      setState(() {
        loading = false;
      });
    } catch (e) {
      Alert(
              context: context,
              title: 'Error Loading data',
              desc: e.message,
              buttons: [],
              style:
                  AlertStyle(isCloseButton: false, isOverlayTapDismiss: false))
          .show();
      await Future.delayed(Duration(seconds: 3));
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    if (loading == true) {
      return Loading();
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
          title: Text(
            'Statistics',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.0437,
              color: Colors.black,
            ),
          ),
        ),
        body: Builder(
          builder: (context) => SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width / 64),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'COVID-19 Statistics',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.cyan,
                      fontSize: MediaQuery.of(context).size.height / 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 64,
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Worldwide',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.purple,
                            fontSize: MediaQuery.of(context).size.height / 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 64,
                        ),
                        Text(
                          'Confirmed: ' + global['TotalConfirmed'].toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.height / 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Recovered: ' + global['TotalRecovered'].toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.height / 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Deaths: ' + global['TotalDeaths'].toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: MediaQuery.of(context).size.height / 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 128,
                        ),
                        Text(
                          'Current: ' +
                              (global['TotalConfirmed'] -
                                      global['TotalRecovered'] -
                                      global['TotalDeaths'])
                                  .toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: MediaQuery.of(context).size.height / 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 32,
                        ),
                        Text(
                          'India',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                            fontSize: MediaQuery.of(context).size.height / 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 64,
                        ),
                        Text(
                          'Confirmed: ' + india['TotalConfirmed'].toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.height / 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Recovered: ' + india['TotalRecovered'].toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.height / 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Deaths: ' + india['TotalDeaths'].toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: MediaQuery.of(context).size.height / 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 128,
                        ),
                        Text(
                          'Current: ' +
                              (india['TotalConfirmed'] -
                                      india['TotalRecovered'] -
                                      india['TotalDeaths'])
                                  .toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: MediaQuery.of(context).size.height / 24,
                            fontWeight: FontWeight.bold,
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
                        Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width / 50),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Statistics of various States of India?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.height / 24,
                                ),
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
                                      width: MediaQuery.of(context).size.width /
                                          160),
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width / 12.8),
                                  color: Colors.white,
                                ),
                                child: DropdownButton(
                                  iconEnabledColor: Colors.blue,
                                  underline: Container(),
                                  hint: Text(
                                    'Select State:',
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              25.6,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  isExpanded: true,
                                  items: states
                                      .map<DropdownMenuItem<String>>((value) {
                                    return DropdownMenuItem<String>(
                                      child: Container(
                                        padding: EdgeInsets.all(
                                            MediaQuery.of(context).size.width /
                                                64),
                                        height:
                                            MediaQuery.of(context).size.height /
                                                10.66,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.blue,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  160),
                                          borderRadius: BorderRadius.circular(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  32),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              value,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          48,
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
                                      state = chosen;
                                    });
                                    statedata();
                                  },
                                  value: state,
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 64,
                              ),
                              Text(
                                'Confirmed: ' +
                                    stateData['confirmed'].toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).size.height / 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Recovered: ' +
                                    stateData['recovered'].toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).size.height / 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Deaths: ' + stateData['deaths'].toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize:
                                      MediaQuery.of(context).size.height / 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 128,
                              ),
                              Text(
                                'Current: ' +
                                    (stateData['confirmed'] -
                                            stateData['recovered'] -
                                            stateData['deaths'])
                                        .toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize:
                                      MediaQuery.of(context).size.height / 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 32,
                        ),
                        Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width / 50),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Statistics of another country?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.height / 24,
                                ),
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
                                      width: MediaQuery.of(context).size.width /
                                          160),
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width / 12.8),
                                  color: Colors.white,
                                ),
                                child: DropdownButton(
                                  iconEnabledColor: Colors.blue,
                                  underline: Container(),
                                  hint: Text(
                                    'Select Country:',
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              25.6,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  isExpanded: true,
                                  items: countries
                                      .map<DropdownMenuItem<String>>((value) {
                                    return DropdownMenuItem<String>(
                                      child: Container(
                                        padding: EdgeInsets.all(
                                            MediaQuery.of(context).size.width /
                                                64),
                                        height:
                                            MediaQuery.of(context).size.height /
                                                10.66,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.blue,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  160),
                                          borderRadius: BorderRadius.circular(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  32),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              value,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
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
                                      country = chosen;
                                    });
                                    countrydata();
                                  },
                                  value: country,
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 64,
                              ),
                              Text(
                                'Confirmed: ' +
                                    otherCountry['TotalConfirmed'].toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).size.height / 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Recovered: ' +
                                    otherCountry['TotalRecovered'].toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).size.height / 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Deaths: ' +
                                    otherCountry['TotalDeaths'].toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize:
                                      MediaQuery.of(context).size.height / 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 128,
                              ),
                              Text(
                                'Current: ' +
                                    (otherCountry['TotalConfirmed'] -
                                            otherCountry['TotalRecovered'] -
                                            otherCountry['TotalDeaths'])
                                        .toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize:
                                      MediaQuery.of(context).size.height / 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
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
}
