class QuestList {
  final List<Quest> quests;

  QuestList({this.quests});

  factory QuestList.fromJson(List<dynamic> json) {
    List<Quest> quests = new List<Quest>();
    quests = json.map((i) => Quest.fromJson(i)).toList();

    return QuestList(quests: quests);
  }
}

class Quest {
  final String ask;

  Quest({this.ask});

  Quest.fromJson(Map<String, dynamic> json) 
    : ask = json['ask'];

  Map<String, dynamic> toJson() => {
    'ask': ask
  };
}
