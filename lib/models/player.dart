import 'package:flutter/material.dart';

class Player with ChangeNotifier{
  int id;
  String name;
  int overall;
  int price;
  String imageUrl;
  int? priceLimit;
  int teamId = 0;
  bool hasBidForTeam = false;

  int teamIdLow = 0;
  bool isUpdated = false;
  String message = '';

  Player({
    required this.id,
    required this.name,
    required this.overall,
    required this.price,
    required this.imageUrl,
    this.priceLimit,
    required this.teamId,
    required this.hasBidForTeam,
  });

  void thisUpdated(int newValue, int teamIdHighest, int teamIdLowest, String messageApi, int? priceLimit) {
    if (priceLimit != null) this.priceLimit = priceLimit;
    isUpdated = true;
    price = newValue;
    teamId = teamIdHighest;
    teamIdLow = teamIdLowest;
    message = messageApi;
    notifyListeners();
    Future.delayed(const Duration(seconds: 5), () {
      isUpdated = false;
      message = '';
      teamIdLow = 0;
      notifyListeners();
    });
  }

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
    priceLimit: json["priceLimit"],
    teamId: json["teamId"] ?? 0,
    hasBidForTeam: json["hasBidForTeam"],
  );
}
