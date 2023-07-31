import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:java_league/config/rest_config.dart';

class Jogador with ChangeNotifier {
  final int id;
  final String name;
  final int overall;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Jogador({
    required this.id,
    required this.name,
    required this.overall,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  factory Jogador.fromJson(Map<String, dynamic> json) => Jogador(
    id: json["id"],
    name: json["name"],
    overall: json["overall"],
    price: json["price"],
    imageUrl: json["imageUrl"],
    isFavorite: json["isFavorite"],
  );

  // void _toggleFavorite() {
  //   isFavorite = !isFavorite;
  //   notifyListeners();
  // }

  // Future<void> toggleFavorite() async {
  //   try {
  //     _toggleFavorite();
  //
  //     final response = await http.patch(
  //       Uri.parse('${RestJavaLeague.serverApiUrl}/$id'),
  //       body: jsonEncode({"isFavorite": isFavorite}),
  //
  //     );
  //
  //     if (response.statusCode >= 400) {
  //       _toggleFavorite();
  //     }
  //   } catch (_) {
  //     _toggleFavorite();
  //   }
  // }
}
