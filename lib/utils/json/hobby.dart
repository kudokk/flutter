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

  Hobby({this.name});

  Hobby.fromJson(Map<String, dynamic> json) 
    : name = json['name'];

  Map<String, dynamic> toJson() => {
    'name': name
  };
}
