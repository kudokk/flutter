import 'package:flutter/material.dart';
import 'package:hobbyapp/utils/sattus/user.dart';
import 'package:hobbyapp/utils/json/quest.dart';
import 'package:hobbyapp/utils/json/hobby.dart';
import 'package:hobbyapp/ui/background.dart';

import 'dart:convert';
import 'dart:math';

class Diagnose extends StatefulWidget {
  @override
  _DiagnoseState createState() => _DiagnoseState();
}

class _DiagnoseState extends State<Diagnose> {
  List _questList = new List();
  int newNum = Random().nextInt(10);
  int _questCount = 0;
  User user = new User();

  void nextQuest(List array) {
    setState(() {
      _questCount++;
      newNum = nextNum(array);   
    });
  }

  int nextNum(List array) {
    var num = array.length == null ? 2 : array.length;
    for(var i = 0; i < 100; i++) {
      var resultRandom = Random().nextInt(num);
      if(!_questList.contains(resultRandom)) {
        _questList.add(resultRandom);
        return resultRandom;
      }
    }
    return 0;
  }

  void updateStatus() {
    statusMap['sociability'] = user.sociability;
    statusMap['collect'] = user.collect;
    statusMap['multiPlay'] = user.multiPlay;
    statusMap['selfPolishing'] = user.selfPolishing;
    statusMap['art'] = user.art;
    statusMap['sport'] = user.sport;
    statusMap['it'] = user.it;
    statusMap['margin'] = user.margin;
    statusMap['costPerformance'] = user.costPerformance;
  }

  String getStatus() {
    // 最大値取得
    int max = -1000;
    // 最低値取得
    int min = 1000;
    statusMap.forEach((key, value) {
      if (max < value) {
        max = value;
      }
      if (min > value) {
        min = value;
      }
    });
    // 絶対値の最大取得
    int result;
    if(min < 0) {
      result = min * -1 <= max ? max : min;
    } else {
      result = min <= max ? max: min;
    }
    // 最大値のstatus配列取得
    List<String> status = new List();
    statusMap.forEach((key, value) {
      if(result == value) {
        status.add(key);
      }
    });
    return status[Random().nextInt(status.length)];
  }

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
                      var questMap = jsonDecode(snapshot.data);
                      QuestList dates = QuestList.fromJson(questMap);
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
                                    user.plusStatus(dates.quests[newNum].choise[index].status);
                                    updateStatus();
                                    nextQuest(dates.quests);
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
                        child: FutureBuilder(
                          future: DefaultAssetBundle.of(context).loadString('assets/json/hobby.json'),
                          builder: (context, snapshot) {
                            if(snapshot.data != null && _questCount >= 10) {
                              var hobbyMap = jsonDecode(snapshot.data);
                              HobbyList dates = HobbyList.fromJson(hobbyMap);
                              return Container(
                                height: 110,
                                child: GridView.builder(
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 5.0,
                                    crossAxisCount: 2,
                                  ),
                                  itemCount: dates.hobbys.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Container(
                                      margin: EdgeInsets.only(
                                        top: 10.0,
                                        left: 10.0,
                                        right: 10.0
                                      ),
                                      child: FlatButton(
                                        onPressed: () {
                                          // nextQuest(dates.hobbys);
                                          print('click');
                                        },
                                        child: Text(
                                          dates.hobbys[index].name
                                        ),
                                      ),
                                    );
                                  },
                                )
                              );
                            } else {
                              return Container();
                            }
                          },
                        )
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
}
