
class Score{

  String name;
  String score;

  Score(String name, String score) {
    this.name = name;
    this.score = score;
  }
  Score.fromJson(Map json)
      : name = json['name'],
        score = json['score'];

  Map toJson() {
    return {'name': name, 'score': score};
  }
}