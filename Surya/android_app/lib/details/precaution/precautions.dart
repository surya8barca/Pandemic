import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

class Precautions extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Precautions> {
  PDFDocument doc;

  void loaddocument() async {
    final result = await PDFDocument.fromAsset("images/precaution.pdf");
    setState(() {
      doc = result;
    });
  }

  @override
  void initState() {
    loaddocument();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: Text(
          'Precautions',
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
                  'COVID-19 Precautions',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.cyan,
                    fontSize: MediaQuery.of(context).size.height / 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: PDFViewer(
                    document: doc,
                    showIndicator: true,
                    showNavigation: true,
                    showPicker: true,
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
