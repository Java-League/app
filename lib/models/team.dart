class Team {
  int id;
  int javalis;
  String name;
  String uniform1;
  String uniform2;
  String emblem;
  String formation;
  List<TeamPlayers>? teamPlayers;

  Team({
    required this.id,
    required this.javalis,
    required this.name,
    required this.uniform1,
    required this.uniform2,
    required this.emblem,
    required this.formation,
    this.teamPlayers,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'javalis': javalis,
      'name': name,
      'uniform1': uniform1,
      'uniform2': uniform2,
      'emblem': emblem,
      'formation': formation,
      'teamPlayers': teamPlayers,
    };
  }

  factory Team.fromJson(Map<String, dynamic> json) => Team(
    id: json["id"],
    javalis: json["javalis"],
    name: json["name"],
    uniform1: json["uniform1"],
    uniform2: json["uniform2"],
    emblem: json["emblem"],
    formation: json["formation"],
    teamPlayers: json["formacao"] == null ? null : List<TeamPlayers>.from(json["formacao"].map((model)=> TeamPlayers.fromJson(model))),
  );
}

class TeamPlayers {
  int playerId;
  int position;
  String name;
  String imageUrl;

  TeamPlayers({
    required this.playerId,
    required this.name,
    required this.position,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'playerId': playerId,
      'name': name,
      'position': position,
      'imageUrl': imageUrl,
    };
  }

  factory TeamPlayers.fromJson(Map<String, dynamic> json) => TeamPlayers(
    playerId: json["playerId"],
    position: json["position"],
    imageUrl: json["imageUrl"],
    name: json["name"],
  );
}


