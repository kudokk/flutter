import 'package:flutter/material.dart';
import 'package:hobbyapp/utils/json/hobby.dart';


class Recognize extends StatelessWidget {
  List<Hobby> _hobbys;
  List _recoHobbyIndex;
  int _index;

  Recognize(this._hobbys, this._recoHobbyIndex, this._index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                child: Text(
                  _hobbys[_recoHobbyIndex[_index]].name
                ),
              ),
              Container(
                child: Text(
                  _hobbys[_recoHobbyIndex[_index]].desc
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
