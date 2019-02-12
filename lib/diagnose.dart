import 'package:flutter/material.dart';

class Diagnose extends StatefulWidget {
  @override
  _DiagnoseState createState() => _DiagnoseState();
}

class _DiagnoseState extends State<Diagnose> {
  void startDiagnose(arg) {
    debugPrint(arg);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'next'
        )
      ),  
    );
  }
}
