class Bid {
  final int? id;
  final double bidValue;
  final DateTime? date;
  final int userId;
  final int playerId;

  Bid({
    this.id,
    required this.bidValue,
    this.date,
    required this.userId,
    required this.playerId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bidValue': bidValue,
      'date': date,
      'userId': userId,
      'playerId': playerId,
    };
  }

  factory Bid.fromJson(Map<String, dynamic> json) => Bid(
    id: json["id"],
    bidValue: json["bidValue"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    userId: json["userId"],
    playerId: json["playerId"],
  );
}
