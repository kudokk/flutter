class User {
  int sociability;
  int collect;
  int multiPlay;
  int selfPolishing;
  int art;
  int sport;
  int it;
  int margin;
  int costPerformance;

  User()
  :sociability = 0,
  collect = 0,
  multiPlay = 0,
  selfPolishing = 0,
  art = 0,
  sport = 0,
  it = 0,
  margin = 0,
  costPerformance = 0;

  plusStatus(str) {
    this.sociability += str.sociability;
    this.collect += str.collect;
    this.multiPlay += str.multiPlay;
    this.selfPolishing += str.selfPolishing;
    this.art += str.art;
    this.sport += str.sport;
    this.it += str.it;
    this.margin += str.margin;
    this.costPerformance += str.costPerformance;
  }
}

Map<String, int> statusMap = {
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
