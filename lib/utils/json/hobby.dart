class HobbyList {
  final List<Hobby> hobbys;

  HobbyList({this.hobbys});

  factory HobbyList.fromJson(List<dynamic> json) {
    List<Hobby> hobbys = new List<Hobby>();
    hobbys = json.map((i) => Hobby.fromJson(i)).toList();

    return HobbyList(hobbys: hobbys);
  }
}

class Hobby {
  final String name;
  final status;
  final String desc;

  Hobby({this.name, this.status, this.desc});

  factory Hobby.fromJson(Map<String, dynamic> json) {
    return Hobby(
      name: json['name'],
      status: Status.fromJson(json['status']),
      desc: json['desc']
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
