import 'package:flutter/material.dart';

import 'home.dart';
import 'diagnose.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hobbyApp',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(),
      routes: <String, WidgetBuilder> {
        '/diagnose': (BuildContext context) => new Diagnose(),
      },
    );
  }
}
