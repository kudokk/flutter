import 'package:flutter/material.dart';
import 'package:hobbyapp/utils/json/hobby.dart';

import 'dart:convert';

class Diagnose extends StatefulWidget {
  @override
  _DiagnoseState createState() => _DiagnoseState();
}

class _DiagnoseState extends State<Diagnose> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 195, 0, 1.0),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background/sheet.png'),
                repeat: ImageRepeat.repeat
              )
            )
          ),
          Container(
            color: Colors.white,
            height: 180,
            margin: EdgeInsets.only(top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: 100,
                  child: Text('text'),
                ),
                Container(
                  height: 80,
                  child: FutureBuilder(
                    future: DefaultAssetBundle.of(context).loadString('assets/json/hobby.json'),
                    builder: (context, snapshot) {
                      var hobbyMap = jsonDecode(snapshot.data);
                      HobbyList dates = HobbyList.fromJson(hobbyMap);
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 7.0,
                          crossAxisCount: 2,
                        ),
                        itemCount: dates.hobbys.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Text(
                            dates.hobbys[index].name
                          );
                        },
                      );
                    },
                  )
                ),
              ],
            )
          )
        ],
      )
    );
  }
}
