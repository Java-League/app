class Team {
  int id;
  int javalis;
  String name;
  String uniform1;
  String uniform2;
  String emblem;

  Team({
    required this.id,
    required this.javalis,
    required this.name,
    required this.uniform1,
    required this.uniform2,
    required this.emblem,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'javalis': javalis,
      'name': name,
      'uniform1': uniform1,
      'uniform2': uniform2,
      'emblem': emblem,
    };
  }

  factory Team.fromJson(Map<String, dynamic> json) => Team(
    id: json["id"],
    javalis: json["javalis"],
    name: json["name"],
    uniform1: json["uniform1"],
    uniform2: json["uniform2"],
    emblem: json["emblem"],
  );
}
