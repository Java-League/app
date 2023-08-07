class Bid {
  int? id;
  int value;
  DateTime? date;
  int? teamId;
  int playerId;

  Bid({
    this.id,
    required this.value,
    this.date,
    this.teamId,
    required this.playerId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
      'date': date,
      'teamId': teamId,
      'playerId': playerId,
    };
  }

  factory Bid.fromJson(Map<String, dynamic> json) => Bid(
    id: json["id"],
    value: json["value"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    teamId: json["teamId"],
    playerId: json["playerId"],
  );
}
