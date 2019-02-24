import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hobbyapp/utils/json/hobby.dart';
import 'package:hobbyapp/ui/background.dart';
import 'package:hobbyapp/ui/backButtonInside.dart';


class Recognize extends StatelessWidget {
  List<Hobby> _hobbys;
  List _recoHobbyIndex;

  Recognize(this._hobbys, this._recoHobbyIndex);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 195, 0, 1.0),
      body: Stack(
        children: <Widget>[
          backGround,
          Container(
            color: Colors.white,
            height: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 30.0, bottom: 20.0),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 190, 72, 1.0)
                  ),
                  child: Text(
                    _hobbys[_recoHobbyIndex[0]].name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Text(
                    _hobbys[_recoHobbyIndex[0]].desc,
                    style: TextStyle(
                      fontSize: 16.0
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 2.0, right: 4.0),
                        child: Icon(
                          Icons.search,
                          size: 18.0,
                          color: Colors.blue,
                        )
                      ),
                      InkWell(
                        child: Text(
                          _hobbys[_recoHobbyIndex[0]].name + ' を始めてみる',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            fontSize: 12.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onTap: () async {
                          if (await canLaunch('https://www.google.co.jp/search?q=')) {
                            print('a');
                            await launch('https://www.google.co.jp/search?q=' + _hobbys[_recoHobbyIndex[1]].name + ' 始め方');
                          }
                        },
                      )
                    ]
                  )
                ),
                Container(
                  margin: EdgeInsets.only(top: 30.0, bottom: 20.0),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 190, 72, 1.0)
                  ),
                  child: Text(
                    _hobbys[_recoHobbyIndex[1]].name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Text(
                    _hobbys[_recoHobbyIndex[1]].desc,
                    style: TextStyle(
                      fontSize: 16.0
                    )
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0, bottom: 60.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 2.0, right: 4.0),
                        child: Icon(
                          Icons.search,
                          size: 18.0,
                          color: Colors.blue,
                        )
                      ),
                      InkWell(
                        child: Text(
                          _hobbys[_recoHobbyIndex[0]].name + ' を始めてみる',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            fontSize: 12.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onTap: () async {
                          if (await canLaunch('https://www.google.co.jp/search?q=')) {
                            print('a');
                            await launch('https://www.google.co.jp/search?q=' + _hobbys[_recoHobbyIndex[1]].name + ' 始め方');
                          }
                        },
                      )
                    ]
                  )
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      height: 30,
                      width: 30,
                      margin: EdgeInsets.only(top: 10.0, right: 10.0),
                      child: FloatingActionButton(
                        heroTag: 'btn2',
                        backgroundColor: Color.fromRGBO(255, 247, 223, 1.0),
                        child: backButtonInside,
                        onPressed: () {
                          Navigator.of(context).pushNamed('/home');
                        },
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      margin: EdgeInsets.only(top: 10.0, right: 10.0),
                      child: FloatingActionButton(
                        heroTag: 'btn3',
                        backgroundColor: Color.fromRGBO(255, 247, 223, 1.0),
                        child: Container(
                          margin: EdgeInsets.only(top: 1.0),
                          child: Text(
                            '戻る',
                            style: TextStyle(
                              fontSize: 10.0,
                              height: 0.8
                            ),
                          )
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                )
              ],
            )
          )
        ]
      )
    );
  }
}
