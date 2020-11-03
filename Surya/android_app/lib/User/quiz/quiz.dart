import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  final int age;
  final String gender;

  Quiz({this.age, this.gender});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Quiz> {
  List answers = ['Yes', 'No'];
  String q1, q2, q3, q4, q5, q6, q7, q8, q9, basic = 'Are You Experiencing ';
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
                        basic + "fever?",
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
                          onChanged: (chosen) async {
                            setState(() {
                              q1 = chosen;
                            });
                          },
                          value: q1,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      Text(
                        basic + "tiredness?",
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
                          onChanged: (chosen) async {
                            setState(() {
                              q2 = chosen;
                            });
                          },
                          value: q2,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      Text(
                        basic + "Difficulty in Breathing?",
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
                          onChanged: (chosen) async {
                            setState(() {
                              q3 = chosen;
                            });
                          },
                          value: q3,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      Text(
                        basic + "Dry Cough?",
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
                          onChanged: (chosen) async {
                            setState(() {
                              q4 = chosen;
                            });
                          },
                          value: q4,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      Text(
                        basic + "Sore throat?",
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
                          onChanged: (chosen) async {
                            setState(() {
                              q5 = chosen;
                            });
                          },
                          value: q5,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      Text(
                        basic + "pain in any part of the body?",
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
                          onChanged: (chosen) async {
                            setState(() {
                              q6 = chosen;
                            });
                          },
                          value: q6,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      Text(
                        basic + "Nasal-Congestion?",
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
                          onChanged: (chosen) async {
                            setState(() {
                              q7 = chosen;
                            });
                          },
                          value: q7,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      Text(
                        basic + "Runny nose?",
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
                          onChanged: (chosen) async {
                            setState(() {
                              q8 = chosen;
                            });
                          },
                          value: q8,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      Text(
                        basic + "Diarrhoea?",
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
                          onChanged: (chosen) async {
                            setState(() {
                              q9 = chosen;
                            });
                          },
                          value: q9,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 16,
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
                            child: RaisedButton(
                              onPressed: () {},
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
                            child: RaisedButton(
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
