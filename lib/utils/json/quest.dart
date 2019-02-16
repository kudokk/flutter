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
  final List<Choise> choise;

  Quest({this.ask, this.choise});

  factory Quest.fromJson(Map<String, dynamic> json) {
    var list = json['choise'] as List;
    List<Choise> choiseList = list.map((i) => Choise.fromJson(i)).toList();

    return Quest(
      ask: json['ask'],
      choise: choiseList
    );
  }
}

class Choise {
  final String text;
  final status;

  Choise({this.text, this.status});

  factory Choise.fromJson(Map<String, dynamic> json) {
    return Choise(
      text: json['text'],
      status: Status.fromJson(json['status'])
    );
  }
}

class Status {
  final int sociability;
  final int collect;
  final int multiPlay;
  final int selfPolishing;
  final int art;
  final int sport;
  final int it;
  final int margin;
  final int costPerformance;

  Status({this.sociability, this.collect, this.multiPlay, this.selfPolishing, this.art, this.sport, this.it, this.margin, this.costPerformance});

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      sociability: json['sociability'],
      collect: json['collect'],
      multiPlay: json['multiPlay'],
      selfPolishing: json['selfPolishing'],
      art: json['art'],
      sport: json['sport'],
      it: json['it'],
      margin: json['margin'],
      costPerformance: json['costPerformance']
    );
  }
}