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
      body: Center(
        child: FutureBuilder(
          future: DefaultAssetBundle.of(context).loadString('assets/json/hobby.json'),
          builder: (context, snapshot) {
            var hobbyMap = jsonDecode(snapshot.data);
            HobbyList dates = HobbyList.fromJson(hobbyMap);
            return ListView.builder(
              itemCount: dates.hobbys.length,
              itemBuilder: (BuildContext context, int index) {
                return Text(dates.hobbys[index].name);
              },
            );
          },
        )
      )
    );
  }

  _createHobbyList(aaaaaa) {
    var text = Text(aaaaaa);
    print(aaaaaa);
    return text;
  }
}
