class User {
  List<int> stockList = new List<int>();

  User({this.stockList});

  void setNum(int num) {
    stockList.add(num);
  }
}
