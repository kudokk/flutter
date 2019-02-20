class User {
  Map<String, int> statusMap;

  User()
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

  plusStatus(str) {
    this.statusMap['sociability'] += str.sociability;
    this.statusMap['collect'] += str.collect;
    this.statusMap['multiPlay'] += str.multiPlay;
    this.statusMap['selfPolishing'] += str.selfPolishing;
    this.statusMap['art'] += str.art;
    this.statusMap['sport'] += str.sport;
    this.statusMap['it'] += str.it;
    this.statusMap['margin'] += str.margin;
    this.statusMap['costPerformance'] += str.costPerformance;
  }
}

class UserRank {
  Map<String, int> statusMap;

  UserRank()
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
}