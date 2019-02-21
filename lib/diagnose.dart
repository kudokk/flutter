import 'package:flutter/material.dart';
import 'package:hobbyapp/utils/sattus/user.dart';
import 'package:hobbyapp/utils/sattus/calculate.dart';
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

  void getUserRank(List array) {
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
                                    calculateMinMax(dates.quests[newNum].choise);
                                    user.plusStatus(dates.quests[newNum].choise[index].status);
                                    _questCount++;
                                    if (_questCount >= 10) {
                                      getUserRank(dates.quests[newNum].choise);
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

  Future getHobbyRank() async {
    String hobby = await _getHobbyJson();
    List hobbyMap = jsonDecode(hobby.toString());
    HobbyList dates = HobbyList.fromJson(hobbyMap);

    List sociabilityInside0 = new List();
    List sociabilityInside1 = new List();
    List sociabilityInside2 = new List();
    List sociabilityInside3 = new List();
    List sociabilityInside4 = new List();
    List sociability = [sociabilityInside0, sociabilityInside1, sociabilityInside2, sociabilityInside3, sociabilityInside4];
    List collect0 = new List();
    List collect1 = new List();
    List collect2 = new List();
    List collect3 = new List();
    List collect4 = new List();
    List collect = [collect0, collect1, collect2, collect3, collect4];
    List multiPlay0 = new List();
    List multiPlay1 = new List();
    List multiPlay2 = new List();
    List multiPlay3 = new List();
    List multiPlay4 = new List();
    List multiPlay = [multiPlay0, multiPlay1, multiPlay2, multiPlay3, multiPlay4];
    List selfPolishing0 = new List();
    List selfPolishing1 = new List();
    List selfPolishing2 = new List();
    List selfPolishing3 = new List();
    List selfPolishing4 = new List();
    List selfPolishing = [selfPolishing0, selfPolishing1, selfPolishing2, selfPolishing3, selfPolishing4];
    List art0 = new List();
    List art1 = new List();
    List art2 = new List();
    List art3 = new List();
    List art4 = new List();
    List art = [art0, art1, art2, art3, art4];
    List sport0 = new List();
    List sport1 = new List();
    List sport2 = new List();
    List sport3 = new List();
    List sport4 = new List();
    List sport = [sport0, sport1, sport2, sport3, sport4];
    List it0 = new List();
    List it1 = new List();
    List it2 = new List();
    List it3 = new List();
    List it4 = new List();
    List it = [it0, it1, it2, it3, it4];
    List margin0 = new List();
    List margin1 = new List();
    List margin2 = new List();
    List margin3 = new List();
    List margin4 = new List();
    List margin = [margin0, margin1, margin2, margin3, margin4];
    List costPerformance0 = new List();
    List costPerformance1 = new List();
    List costPerformance2 = new List();
    List costPerformance3 = new List();
    List costPerformance4 = new List();
    List costPerformance = [costPerformance0, costPerformance1, costPerformance2, costPerformance3, costPerformance4];
    for (var i = 0; i < dates.hobbys.length; i++) {
      int sociabilityIndex = dates.hobbys[i].status.sociability + 2;
      sociability[sociabilityIndex].add(i);
      int collectIndex = dates.hobbys[i].status.collect + 2;
      collect[collectIndex].add(i);
      int multiPlayIndex = dates.hobbys[i].status.multiPlay + 2;
      multiPlay[multiPlayIndex].add(i);
      int selfPolishingIndex = dates.hobbys[i].status.selfPolishing + 2;
      selfPolishing[selfPolishingIndex].add(i);
      int artIndex = dates.hobbys[i].status.art + 2;
      art[artIndex].add(i);
      int sportIndex = dates.hobbys[i].status.sport + 2;
      sport[sportIndex].add(i);
      int itIndex = dates.hobbys[i].status.it + 2;
      it[itIndex].add(i);
      int marginIndex = dates.hobbys[i].status.margin + 2;
      margin[marginIndex].add(i);
      int costPerformanceIndex = dates.hobbys[i].status.costPerformance + 2;
      costPerformance[costPerformanceIndex].add(i);
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
