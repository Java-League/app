import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:java_league/config/rest_config.dart';

class Auth with ChangeNotifier {
  Future<void> login(String login, String password) async {
    final uri = Uri.parse('${RestJavaLeague.serverApiUrl}/auth/login');
    final response = await RestJavaLeague.http.post(
      uri,
      body: jsonEncode({'login': login, 'password': password}),
      headers: RestJavaLeague.headers,
    );
    print(jsonDecode(response.body));
  }

  Future<void> register(String login, String password) async {
    final uri = Uri.parse('${RestJavaLeague.serverApiUrl}/auth/register');
    final response = await RestJavaLeague.http.post(
      uri,
      body: jsonEncode({'login': login, 'password': password, 'role': 'ADMIN'}),
      headers: RestJavaLeague.headers,
    );
    print(jsonDecode(response.body));
  }
}
