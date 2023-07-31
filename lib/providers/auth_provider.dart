import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:java_league/config/rest_config.dart';
import 'package:java_league/models/auth.dart';

class AuthProvider with ChangeNotifier {
  final storage = const FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));

  String? _token;
  int? _id;
  double? javalis;

  bool get isAuth {
    return _token != null;
  }

  String? get token {
    return isAuth ? _token : null;
  }

  // Auth responseData = await account.authenticate(email, password);
  // _token = responseData.idToken;
  // _username = email;
  // try {
  // storage.write(key: '_token', value: _token!);
  // storage.write(key: '_username', value: email);
  // storage.write(key: '_usernameKey', value: password);
  // } catch (e) {
  // // do nothing
  // }


  Future<void> login(String login, String password) async {
    final uri = Uri.parse('${RestJavaLeague.serverApiUrl}/auth/login');
    final response = await RestJavaLeague.http.post(
      uri,
      body: jsonEncode({'login': login, 'password': password}),
    );
    final responseData = json.decode(utf8.decode(response.bodyBytes));
    final Auth auth = Auth.fromJson(responseData);

    storage.write(key: '_token', value: auth.idToken);
    _token = auth.idToken;
    notifyListeners();
    print(auth.idToken);
    // return Auth.fromJson(responseData);
  }

  Future<void> register(String login, String password) async {
    final uri = Uri.parse('${RestJavaLeague.serverApiUrl}/auth/register');
    final response = await RestJavaLeague.http.post(
      uri,
      body: jsonEncode({'login': login, 'password': password, 'role': 'ADMIN'}),
    );
    print(jsonDecode(response.body));
  }
}
