class HobbyRank {
  Map<String, dynamic> statusMap;

  HobbyRank()
  : statusMap = {
    'sociability': 0,
    'collect': 0,
    'multiPlay': 0,
    'selfPolishing': 0,
    'art': 0,
    'sport': 0,
    'it': 0,
    'margin': 0,
    'costPerformance': 0
  };
  
  factory HobbyRank.addList() {
		HobbyRank rankMap = new HobbyRank();
    rankMap.statusMap.forEach((key, value) {
			HobbyRankLists lists = HobbyRankLists.addList();
      rankMap.statusMap[key] = lists.hobbyRankLists;
    });
    return rankMap;
	}
}

class HobbyRankLists {
  List<List> hobbyRankLists;

  HobbyRankLists({this.hobbyRankLists});

  factory HobbyRankLists.addList() {
    List<List> hobbyRankLists = new List<List>();
    for(int i = 0; i < 5; i++) {
      List insideList = new List();
      hobbyRankLists.add(insideList);
    }
    return HobbyRankLists(hobbyRankLists: hobbyRankLists);
  }
}

