import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_interceptor/http_interceptor.dart';

class RestJavaLeague {

  static const String HEADER_TOTAL = 'x-total-count';

  static String get serverApiUrl {
    return 'http://192.168.2.11:8080';
  }

  static String get serverApiWs {
    return 'ws://192.168.2.11:8080/ws';
  }

  static InterceptedClient? _http;

  static InterceptedClient get http {
    _http ??= InterceptedClient.build(
      interceptors: [TokenInterceptor()],
    );
    return _http!;
  }
}

class TokenInterceptor implements InterceptorContract {

  final storage = const FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    String? token;
    try {
      token = await storage.read(key: '_token');
    } catch (_) {
      // do nothing
    }

    data.headers["Content-Type"] = "application/json;charset=UTF-8";
    // data.headers["X-AUTH-TOKEN"] = "2596e66a-f055-489d-8ea1-946ed7d6b696";
    // data.headers["accept"] = "application/json";
    // data.headers["Origin"] = "https://app.facilite.co";
    if (token != null) {
      data.headers["Authorization"] = "Bearer $token";
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (data.statusCode < 200 || data.statusCode >= 300) {
      print('Erro - Codigo HTTP: ${data.statusCode}');
      if (data.body != null) {
        print(json.decode(data.body!));
      }
    }
    return data;
  }
}
