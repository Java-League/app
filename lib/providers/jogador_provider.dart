import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:java_league/config/rest_config.dart';
import 'package:java_league/models/jogadores.dart';

class JogadorProvider with ChangeNotifier {
 final String _token;
 List<Jogador> _jogadores = [];

 List<Jogador> get items => [..._jogadores];
 List<Jogador> get favoriteItems =>
     _jogadores.where((jogador) => jogador.isFavorite).toList();

 JogadorProvider(this._token, this._jogadores);

 int get itemsCount {
  return _jogadores.length;
 }

 Future<void> loadPlayers() async {
  _jogadores.clear();

  final uri = Uri.parse('${RestJavaLeague.serverApiUrl}/player');
  final response = await RestJavaLeague.http.get(uri);
  if (response.body == 'null') return;

  List<dynamic> responseData = json.decode(utf8.decode(response.bodyBytes));

  _jogadores = List<Jogador>.from(responseData.map((model)=> Jogador.fromJson(model)));
  notifyListeners();
 }

}