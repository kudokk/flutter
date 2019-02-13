import 'package:flutter/material.dart';
import 'utils/json.dart';

class Diagnose extends StatefulWidget {
  @override
  _DiagnoseState createState() => _DiagnoseState();
}

class _DiagnoseState extends State<Diagnose> {
  String _hobby = parseJsonFromAssets('assets/json/person.json');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            
          ],
        )
      )
    );
  }
}
