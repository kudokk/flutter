import 'package:flutter/material.dart';
import 'package:hobbyapp/utils/status/user.dart';
import 'package:hobbyapp/utils/status/calculate.dart';
import 'package:hobbyapp/utils/status/hobbyRank.dart';
import 'package:hobbyapp/utils/json/quest.dart';
import 'package:hobbyapp/utils/json/hobby.dart';
import 'package:hobbyapp/ui/background.dart';

import 'package:flutter/services.dart' show rootBundle;
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
  User userRank = new User();
  Max cMax = new Max();
  Min cMin = new Min();
  HobbyRank rankMap = new HobbyRank.addList();
  List recoHobbyIndex = new List();

  void nextQuest(List array) {
    setState(() {
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

  List randoms(List array, int len) {
    List numList = new List();
    while(len > 0) {
      int num = Random().nextInt(array.length);
      if (!numList.contains(num)) {
        numList.add(num);
        len--;
      }
    }
    return numList;
  }

  Future<String> _getQuestJson() async {
    return await DefaultAssetBundle.of(context).loadString('assets/json/quest.json');
  }

  Future<String> _getHobbyJson() async {
    return await rootBundle.loadString('assets/json/hobby.json');
  }

  Map getStatus() {
    // 最大値取得
    int max = -1000;
    List sortList = new List();
    userRank.statusMap.forEach((key, value) {
      sortList.add(value);
      if (max < value) {
        max = value;
      }
    });
    print(max);
    // 最大値のstatus配列取得
    List status = new List();
    Map matchResult = new Map();
    userRank.statusMap.forEach((key, value) {
      if (max == value) {
        status.add(key);
      }
    });
    if(status.length >= 2) {
      print('status >= 2 $status');
      // ２つランダム
      List matchIndex = randoms(status, 2);
      Map one = {status[matchIndex[0]]: userRank.statusMap[status[matchIndex[0]]]};
      Map two = {status[matchIndex[1]]: userRank.statusMap[status[matchIndex[1]]]};
      matchResult.addAll(one);
      matchResult.addAll(two);
    } else if(status.length == 1) {
      print('status == 1 $status');
      // 次の値で
      Map one = {status[0]: userRank.statusMap[status[0]]};
      matchResult.addAll(one);
      List result = new List();
      sortList.sort();
      int max = sortList[sortList.length - 2];
      userRank.statusMap.forEach((key, value) {
        if (max == value) {
          result.add(key);
        }
      });
      int random = randoms(result, 1)[0];
      Map two = {result[random]: userRank.statusMap[result[random]]};
      matchResult.addAll(two);
    }
    // ２つのkey, valueを返したい。
    return matchResult;
  }

  List getAttribute(int max, int min) {
    List attribute = new List();
    int sum = min >=0 ? max + min : max - min;
    int n = 4;
    for(int i = 0; i < n - 1; i++) {
      double num = (sum + i) / n;
      attribute.add(num.toInt());
    }
    List punctuation = new List();
    punctuation.add(min);
    for(int i = 0; i < n - 1; i++) {
      punctuation.add(min + attribute[i]);
      min = punctuation[i + 1];
    }
    punctuation.add(max);
    return punctuation;
  }

  void setRecoHobby(List array) {
    user.statusMap.forEach((key, value) {
      // 分配配列作成
      List attributeList = getAttribute(cMax.statusMap[key], cMin.statusMap[key]);
      // ユーザランク取得
      for(int j = 0; j < attributeList.length; j++) {
        if (user.statusMap[key] <= attributeList[j]) {
          userRank.statusMap[key] = j;
          break;
        }
      }
    });
    Map recoStatus = getStatus();
    recoStatus.forEach((key, value) {
      print(key);
      print(value);
      print(rankMap.statusMap[key]);
      recoHobbyIndex = randoms(rankMap.statusMap[key][value], 2);
      print(recoHobbyIndex);
    });
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
                    future: _getQuestJson(),
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
                                    if (_questCount == 0) {
                                      getHobbyRank();
                                    }
                                    calculateMinMax(dates.quests[newNum].choise);
                                    user.plusStatus(dates.quests[newNum].choise[index].status);
                                    _questCount++;
                                    if (_questCount >= 10) {
                                      setRecoHobby(dates.quests[newNum].choise);
                                    }
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
                                  itemCount: recoHobbyIndex.length,
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
                                          dates.hobbys[recoHobbyIndex[index]].name
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

  Future getHobbyRank() async {
    String hobby = await _getHobbyJson();
    List hobbyMap = jsonDecode(hobby.toString());
    HobbyList dates = HobbyList.fromJson(hobbyMap);

    for (var i = 0; i < dates.hobbys.length; i++) {
      int sociabilityIndex = dates.hobbys[i].status.sociability + 2;
      rankMap.statusMap['sociability'][sociabilityIndex].add(i);
      int collectIndex = dates.hobbys[i].status.collect + 2;
      rankMap.statusMap['collect'][collectIndex].add(i);
      int multiPlayIndex = dates.hobbys[i].status.multiPlay + 2;
      rankMap.statusMap['multiPlay'][multiPlayIndex].add(i);
      int selfPolishingIndex = dates.hobbys[i].status.selfPolishing + 2;
      rankMap.statusMap['selfPolishing'][selfPolishingIndex].add(i);
      int artIndex = dates.hobbys[i].status.art + 2;
      rankMap.statusMap['art'][artIndex].add(i);
      int sportIndex = dates.hobbys[i].status.sport + 2;
      rankMap.statusMap['sport'][sportIndex].add(i);
      int itIndex = dates.hobbys[i].status.it + 2;
      rankMap.statusMap['it'][itIndex].add(i);
      int marginIndex = dates.hobbys[i].status.margin + 2;
      rankMap.statusMap['margin'][marginIndex].add(i);
      int costPerformanceIndex = dates.hobbys[i].status.costPerformance + 2;
      rankMap.statusMap['costPerformance'][costPerformanceIndex].add(i);
    }
  }

  void calculateMinMax(List array) {
    List sociability = new List();
    List collect = new List();
    List multiPlay = new List();
    List selfPolishing = new List();
    List art = new List();
    List sport = new List();
    List it = new List();
    List margin = new List();
    List costPerformance = new List();
    array.forEach((element) {
      sociability.add(element.status.sociability);
      collect.add(element.status.collect);
      multiPlay.add(element.status.multiPlay);
      selfPolishing.add(element.status.selfPolishing);
      art.add(element.status.art);
      sport.add(element.status.sport);
      it.add(element.status.it);
      margin.add(element.status.margin);
      costPerformance.add(element.status.costPerformance);
    });
    sociability.sort();
    cMin.statusMap['sociability'] += sociability.first;
    cMax.statusMap['sociability'] += sociability.last;
    collect.sort();
    cMin.statusMap['collect'] += collect.first;
    cMax.statusMap['collect'] += collect.last;
    multiPlay.sort();
    cMin.statusMap['multiPlay'] += multiPlay.first;
    cMax.statusMap['multiPlay'] += multiPlay.last;
    selfPolishing.sort();
    cMin.statusMap['selfPolishing'] += selfPolishing.first;
    cMax.statusMap['selfPolishing'] += selfPolishing.last;
    art.sort();
    cMin.statusMap['art'] += art.first;
    cMax.statusMap['art'] += art.last;
    sport.sort();
    cMin.statusMap['sport'] += sport.first;
    cMax.statusMap['sport'] += sport.last;
    it.sort();
    cMin.statusMap['it'] += it.first;
    cMax.statusMap['it'] += it.last;
    margin.sort();
    cMin.statusMap['margin'] += margin.first;
    cMax.statusMap['margin'] += margin.last;
    costPerformance.sort();
    cMin.statusMap['costPerformance'] += costPerformance.first;
    cMax.statusMap['costPerformance'] += costPerformance.last;
  }
}
