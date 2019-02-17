import 'package:flutter/material.dart';
import 'package:hobbyapp/utils/json/quest.dart';
import 'package:hobbyapp/ui/background.dart';
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
          backGround,
          // questArea
          Container(
            color: Colors.white,
            height: 234,
            margin: EdgeInsets.only(top: 50),
              child: Column(
                children: <Widget>[
                  // questArea
                  FutureBuilder(
                    future: DefaultAssetBundle.of(context).loadString('assets/json/quest.json'),
                    builder: (context, snapshot) {
                      var hobbyMap = jsonDecode(snapshot.data);
                      QuestList dates = QuestList.fromJson(hobbyMap);
                      newNum = firstRandomStock(dates.quests);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text(
                              dates.quests[newNum].ask,
                              style: TextStyle(
                                fontSize: 16.0
                              ),
                              textAlign: TextAlign.center,
                            )
                          ),
                          Container(
                            height: 110,
                            child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 5.0,
                                crossAxisCount: 2,
                            ),
                            itemCount: dates.quests[newNum].choise.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: EdgeInsets.only(
                                  top: 10.0,
                                  left: 10.0,
                                  right: 10.0
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1.0),
                                  borderRadius: BorderRadius.circular(30.0)
                                ),
                                child: FlatButton(
                                  onPressed: () {
                                    print(newNum);
                                    newNum = firstRandomStock(dates.quests);
                                    print(newNum);
                                  },
                                  child: Text(
                                  dates.quests[newNum].choise[index].text,
                                  style: TextStyle(
                                    fontSize: 12.0,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                                )
                              );
                            },
                          )
                        )
                      ],
                    );
                  },
                ),
                // hobbyArea
                Container(
                  color: Colors.white,
                  height: 100,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          'data'
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          )
        ],
      )
    );
  }

  int firstRandomStock(List array) {
      var random = Random();
      stock.stockList = new List();
      var resultRandom = random.nextInt(array.length);
      if(!stock.stockList.contains(resultRandom)) {
        stock.setNum(resultRandom);
        return resultRandom;
      }
      return 0;
  }

  int randomStock(List array) {
    var random = Random();
    var resultRandom = random.nextInt(array.length);
      if(!stock.stockList.contains(resultRandom)) {
        stock.setNum(resultRandom);
        print(resultRandom);
        return resultRandom;
      }
      return 0;
  }
}
