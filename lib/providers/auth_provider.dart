import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:java_league/config/rest_config.dart';
import 'package:java_league/models/auth.dart';
import 'package:java_league/models/team.dart';
import 'package:java_league/services/team_service.dart';

class AuthProvider with ChangeNotifier {
  final storage = const FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));

  String? _token;
  int? _teamId;
  Team? _team;

  bool get isAuth {
    return _token != null;
  }

  String? get token {
    return isAuth ? _token : null;
  }

  int get teamId {
    return _teamId ?? 0;
  }

  Team? get team {
    return _team;
  }

  void getCurrentTeam() {
    TeamService().getTeam().then((value) {
      _team = value;
      notifyListeners();
    });
  }

  Future<void> login(String login, String password) async {
    storage.delete(key: '_token');
    final uri = Uri.parse('${RestJavaLeague.serverApiUrl}/auth/login');
    final response = await RestJavaLeague.http.post(
      uri,
      body: jsonEncode({'login': 'admin', 'password': 'admin'}),
    );
    final responseData = json.decode(utf8.decode(response.bodyBytes));
    final Auth auth = Auth.fromJson(responseData);

    storage.write(key: '_token', value: auth.idToken);
    _token = auth.idToken;
    _teamId = auth.teamId;
    notifyListeners();
    print(auth.idToken);
  }

  Future<void> register(String login, String password) async {
    storage.delete(key: '_token');
    final uri = Uri.parse('${RestJavaLeague.serverApiUrl}/auth/register');
    final response = await RestJavaLeague.http.post(
      uri,
      body: jsonEncode({'login': login, 'password': password, 'role': 'ADMIN'}),
    );
    print(jsonDecode(response.body));
  }

  void logout() {
    storage.delete(key: '_token');
    _token = null;
    notifyListeners();
  }
}
