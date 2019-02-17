class User {
  List<int> stockList;

  User({this.stockList});

  void setNum(int num) {
    stockList.add(num);
  }
}
