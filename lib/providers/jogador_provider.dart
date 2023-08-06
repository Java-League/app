import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:java_league/config/rest_config.dart';
import 'package:java_league/models/player.dart';

class JogadorProvider with ChangeNotifier {
 List<Player> _jogadores = [];

 List<Player> get items => [..._jogadores];

 JogadorProvider(this._jogadores);

 int get itemsCount {
  return _jogadores.length;
 }

 Future<void> loadPlayers() async {
  _jogadores.clear();

  final uri = Uri.parse('${RestJavaLeague.serverApiUrl}/api/player');
  final response = await RestJavaLeague.http.get(uri);
  if (response.body == 'null') return;

  List<dynamic> responseData = json.decode(utf8.decode(response.bodyBytes));

  _jogadores = List<Player>.from(responseData.map((model)=> Player.fromJson(model)));
  notifyListeners();
 }
}