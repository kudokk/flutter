import 'package:flutter/material.dart';
import 'package:hobbyapp/ui/background.dart';

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> 
  with SingleTickerProviderStateMixin {
    AnimationController controller;

    initState() {
      super.initState();
      controller = AnimationController(
        duration: Duration(milliseconds: 600), vsync: this)
        ..addListener(() {
          setState(() {});
        })
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            controller.reverse();
          } else if (status == AnimationStatus.dismissed) {
            controller.forward();
          }
        });
      controller.forward();
    }

    @override
      dispose() {
        controller.dispose();
        super.dispose();
      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 203, 36, 1.0),
      body: Stack(
        children: <Widget>[
          backGround,
          Container(
            color: Color.fromRGBO(255, 195, 0, 1.0),
            height: 300,
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            margin: EdgeInsets.only(top: 200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    bottom: 50.0
                  ),
                  child: Text(
                    '趣味診断',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold
                    )
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/diagnose');
                  },
                  color: Color.fromRGBO(255, 165, 0, controller.value),
                  child: Text(
                    '趣味診断を始める',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400
                    )
                  )
                )
              ],
            ) 
          ),
        ]
      ),
    );
  }
}
