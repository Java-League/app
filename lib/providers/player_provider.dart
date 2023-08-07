import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:java_league/config/rest_config.dart';
import 'package:java_league/models/player.dart';

class PlayerProvider with ChangeNotifier {
 List<Player> _players = [];

 List<Player> get players => [..._players];

 PlayerProvider(this._players);

 int get playersCount {
  return _players.length;
 }

 Future<void> loadPlayers() async {
  _players.clear();

  final uri = Uri.parse('${RestJavaLeague.serverApiUrl}/api/player');
  final response = await RestJavaLeague.http.get(uri);
  if (response.body == 'null') return;

  List<dynamic> responseData = json.decode(utf8.decode(response.bodyBytes));

  _players = List<Player>.from(responseData.map((model)=> Player.fromJson(model)));
  notifyListeners();
 }
}