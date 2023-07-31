import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_interceptor/http_interceptor.dart';

class RestJavaLeague {

  static const String HEADER_TOTAL = 'x-total-count';

  static String get serverApiUrl {
    //   return 'https://javaleague.com.br/api';
    return 'http://192.168.18.6:8080';
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
