import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'login.dart';

class Register extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Register> {
  //variables
  bool hidepassword = true, rememberme = false;
  String email,
      password,
      name,
      state,
      city,
      address1,
      district,
      dob,
      gender,
      formDob = "Date of Birth",
      userid;
  int aadharCardNo, mobileNo,age;
  List states = [
        'Andaman Nicobar',
        'Andhra Pradesh',
        'Arunachal Pradesh',
        'Assam',
        'Bihar',
        'Chandigarh',
        'Chhattisgarh',
        'Dadra Nagar Haveli',
        'Daman Diu',
        'Delhi',
        'Goa',
        'Gujarat',
        'Haryana',
        'Himachal Pradesh',
        'Jammu Kashmir',
        'Jharkhand',
        'Karnataka',
        'Kerala',
        'Ladakh',
        'Lakshadweep',
        'Madhya Pradesh',
        'Maharashtra',
        'Manipur',
        'Meghalaya',
        'Mizoram',
        'Nagaland',
        'Odisha',
        'Puducherry',
        'Punjab',
        'Rajasthan',
        'Sikkim',
        'Tamil Nadu',
        'Telangana',
        'Tripura',
        'Uttar Pradesh',
        'Uttarakhand',
        'West Bengal'
      ],genders=['Male','Female','Other'],
      districts = [];

  User temp;
  final CollectionReference fire =
      FirebaseFirestore.instance.collection('UserData');

  Future<void> getdistricts() async {
    try {
      String url = 'https://getdistricts.herokuapp.com/districts/?State=$state';
      Response data = await get(url);
      Map result = jsonDecode(data.body);
      setState(() {
        districts = result['Districts'];
      });
      print(districts);
    } catch (e) {
      Navigator.pop(context);
      Alert(
              context: context,
              title: 'Error',
              desc: e.message,
              buttons: [],
              style:
                  AlertStyle(isCloseButton: false, isOverlayTapDismiss: false))
          .show();
      await Future.delayed(Duration(seconds: 3));
    }
  }

  bool checkdetails() {
    if (email != null &&
        password != null &&
        name != null &&
        dob != null &&
        mobileNo.toString().length == 10 &&
        aadharCardNo.toString().length == 12 &&
        address1 != null &&
        city != null &&
        state != null &&
        district != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> registeruser() async {
    try {
      await Firebase.initializeApp();
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      setState(() {
        temp = result.user;
        userid = result.user.uid;
      });
      return true;
    } catch (e) {
      Navigator.pop(context);
      Alert(
              context: context,
              title: 'Registration Error',
              desc: e.message,
              buttons: [],
              style:
                  AlertStyle(isCloseButton: false, isOverlayTapDismiss: false))
          .show();
      await Future.delayed(Duration(seconds: 3));
      return false;
    }
  }

  Future<bool> adddetails() async {
    try {
      String address =
          (address1 + ", " + city + ", " + district + ", " + state);
      List risk = [];
      fire.doc(userid).set({
        'name': name,
        'age':age,
        'gender':gender,
        'date_of_birth': dob,
        'mobile_no': mobileNo,
        'aadhar': aadharCardNo,
        'address_line': address1,
        'city':city,
        'district':district,
        'state':state,
        'final_address':address,
        'risk': risk,
      });
      return true;
    } catch (e) {
      Navigator.pop(context);
      Alert(
              context: context,
              title: 'Registration Error',
              desc: e.message,
              buttons: [],
              style:
                  AlertStyle(isCloseButton: false, isOverlayTapDismiss: false))
          .show();
      await Future.delayed(Duration(seconds: 3));
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
            'Register',
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
                        'Enter your personal details',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        maxLength: 20,
                        maxLengthEnforced: true,
                        decoration: fieldDecoration.copyWith(
                            labelText: 'Full Name', helperText: '*required'),
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: MediaQuery.of(context).size.height / 32),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              name = value;
                            });
                          }
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
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
                            'Select Gender:',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height / 25.6,
                              color: Colors.blue,
                            ),
                          ),
                          isExpanded: true,
                          items: genders.map<DropdownMenuItem<String>>((value) {
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
                          onChanged: (chosen) async {
                            setState(() {
                              gender = chosen;
                            });
                          },
                          value: gender,
                        ),
                      ),
                      Text(
                        '*required',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: MediaQuery.of(context).size.height / 50,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        maxLength: 3,
                        decoration: fieldDecoration.copyWith(
                          labelText: 'Age',
                          helperText: '*required',
                        ),
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: MediaQuery.of(context).size.height / 32),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              age = int.parse(value);
                            });
                          }
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      InkWell(
                        onTap: () async {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime(2000),
                                  firstDate: DateTime(1920),
                                  lastDate: DateTime.now())
                              .then((date) {
                            if (date != null) {
                              setState(() {
                                formDob =
                                    "${date.toString().split(' ')[0].split('-')[2]}/${date.toString().split(' ')[0].split('-')[1]}/${date.toString().split(' ')[0].split('-')[0]}";
                                dob = formDob;
                              });
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            children: <Widget>[
                              Text(
                                formDob,
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 30),
                              ),
                              SizedBox(
                                width: 60,
                              ),
                              Icon(
                                Icons.calendar_today,
                                color: Colors.blue,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        '*required',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: MediaQuery.of(context).size.height / 50,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        maxLength: 10,
                        decoration: fieldDecoration.copyWith(
                          labelText: 'Mobile Number',
                          helperText: '*required',
                        ),
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: MediaQuery.of(context).size.height / 32),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              mobileNo = int.parse(value);
                            });
                          }
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        maxLength: 12,
                        decoration: fieldDecoration.copyWith(
                          labelText: 'Aadhar Card Number',
                          helperText: '*required',
                        ),
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: MediaQuery.of(context).size.height / 32),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              aadharCardNo = int.parse(value);
                            });
                          }
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        maxLength: 80,
                        minLines: 2,
                        maxLines: 2,
                        decoration: fieldDecoration.copyWith(
                            labelText: 'Address Line 1',
                            helperText: '*required'),
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: MediaQuery.of(context).size.height / 32),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              address1 = value;
                            });
                          }
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        maxLength: 15,
                        decoration: fieldDecoration.copyWith(
                          labelText: 'City',
                          helperText: '*required',
                        ),
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: MediaQuery.of(context).size.height / 32),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              city = value;
                            });
                          }
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
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
                            'Select State:',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height / 25.6,
                              color: Colors.blue,
                            ),
                          ),
                          isExpanded: true,
                          items: states.map<DropdownMenuItem<String>>((value) {
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
                          onChanged: (chosen) async {
                            setState(() {
                              state = chosen;
                            });
                            Alert(
                                context: context,
                                style: AlertStyle(
                                  backgroundColor: Colors.white,
                                  isOverlayTapDismiss: false,
                                  isCloseButton: false,
                                ),
                                title: "Please wait",
                                desc: "Getting District List...",
                                buttons: [],
                                content: Container(
                                  child: SpinKitCircle(color: Colors.blue),
                                )).show();
                            await getdistricts();
                            Navigator.pop(context);
                          },
                          value: state,
                        ),
                      ),
                      Text(
                        '*required',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: MediaQuery.of(context).size.height / 50,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
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
                            'Select District:',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height / 25.6,
                              color: Colors.blue,
                            ),
                          ),
                          isExpanded: true,
                          items:
                              districts.map<DropdownMenuItem<String>>((value) {
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
                              district = chosen;
                            });
                          },
                          value: district,
                        ),
                      ),
                      Text(
                        '*required',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: MediaQuery.of(context).size.height / 50,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      Text(
                        'Enter your login credentials',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        decoration: fieldDecoration.copyWith(
                            labelText: 'Email Address',
                            hintText: 'Example@domain.com',
                            helperText: '*required'),
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
                          helperText: '*required',
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
                      SizedBox(height: MediaQuery.of(context).size.height / 32),
                      ButtonTheme(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(
                                MediaQuery.of(context).size.width / 10.666)),
                        minWidth: MediaQuery.of(context).size.width / 2.1333,
                        height: MediaQuery.of(context).size.height / 10.666,
                        buttonColor: Colors.cyan,
                        child: RaisedButton(
                          onPressed: () async {
                            Alert(
                                context: context,
                                style: AlertStyle(
                                  backgroundColor: Colors.white,
                                  isOverlayTapDismiss: false,
                                  isCloseButton: false,
                                ),
                                title: "Please wait",
                                desc: "Registering User...",
                                buttons: [],
                                content: Container(
                                  child: SpinKitCircle(color: Colors.blue),
                                )).show();
                            if (checkdetails()) {
                              bool confirmation1 = await registeruser();
                              if (confirmation1) {
                                bool confirmation2 = await adddetails();
                                if (confirmation2) {
                                  Navigator.pop(context);
                                  Alert(
                                          context: context,
                                          title: 'User Registered',
                                          desc: 'Redirecting to Login page..',
                                          buttons: [],
                                          content: Container(
                                            child: SpinKitCircle(
                                                color: Colors.blue),
                                          ),
                                          style: AlertStyle(
                                              isCloseButton: false,
                                              isOverlayTapDismiss: false))
                                      .show();
                                  await Future.delayed(Duration(seconds: 3));
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Login(),
                                      ));
                                } else {
                                  temp.delete();
                                }
                              } else {
                                Navigator.pop(context);
                              }
                            } else {
                              Navigator.pop(context);
                              Alert(
                                      context: context,
                                      title: 'Invalid Input',
                                      desc:
                                          'All inputs are required and in correct format',
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
                        'Already a User?',
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
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ));
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
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
