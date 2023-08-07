import 'package:flutter/material.dart';

class Player with ChangeNotifier{
  int id;
  String name;
  int overall;
  int price;
  String imageUrl;
  int? teamId;

  Player({
    required this.id,
    required this.name,
    required this.overall,
    required this.price,
    required this.imageUrl,
    this.teamId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'overall': overall,
      'price': price,
      'imageUrl': imageUrl,
      'teamId': teamId,
    };
  }

  factory Player.fromJson(Map<String, dynamic> json) => Player(
    id: json["id"],
    name: json["name"],
    overall: json["overall"],
    price: json["price"],
    imageUrl: json["imageUrl"],
    teamId: json["teamId"],
  );
}
