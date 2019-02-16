import 'package:flutter/material.dart';
import 'package:hobbyapp/utils/json/quest.dart';
import 'package:hobbyapp/utils/sattus/user.dart';

import 'dart:convert';
import 'dart:math';

class Diagnose extends StatefulWidget {
  @override
  _DiagnoseState createState() => _DiagnoseState();
}

class _DiagnoseState extends State<Diagnose> {
  User stock = User();
  int newNum;

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
              child: FutureBuilder(
                future: DefaultAssetBundle.of(context).loadString('assets/json/quest.json'),
                builder: (context, snapshot) {
                  var hobbyMap = jsonDecode(snapshot.data);
                  QuestList dates = QuestList.fromJson(hobbyMap);
                  newNum = randomStock(dates.quests);
                  return Column(
                    children: <Widget>[
                      Container(
                        height: 80,
                        child: Text('a')
                      ),
                      Container(
                        height: 100,
                        child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 7.0,
                          crossAxisCount: 2,
                        ),
                        itemCount: dates.quests[newNum].choise.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Text(
                            dates.quests[newNum].choise[index].text
                          );
                        },
                      )
                      )
                    ],
                  );
                },
              )
            ),
        ],
      )
    );
  }

  int randomStock(List array) {
      var random = Random();
      stock.stockList = new List();
      var resultRandom = random.nextInt(array.length);
      if(!stock.stockList.contains(resultRandom)) {
        stock.setNum(resultRandom);
        print(resultRandom);
        return resultRandom;
      }
      return 0;
  }
}
