import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:java_league/config/rest_config.dart';
import 'package:java_league/models/bid.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class WebSocketProvider extends ChangeNotifier {
  late StompClient _stompClient;
  final storage = const FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));

  final _messageStreamController = StreamController<dynamic>.broadcast();
  Stream<dynamic> get messageStream => _messageStreamController.stream;

  Future<void> initConnection(String destination) async {
    String? token;
    try {
      token = await storage.read(key: '_token');
    } catch (_) {
      // do nothing
    }
    if (token == null) return;
    final stompConfig = StompConfig(
      url: RestJavaLeague.serverApiWs,
      onConnect: (stompFrame) => onConnect(_stompClient, stompFrame, destination),
      onWebSocketError: (e) => print('onWebSocketError $e'),
      onStompError: (d) => print('error stomp'),
      onDisconnect: (f) => print('disconnected'),
      stompConnectHeaders: {'Authorization': 'Bearer $token'},
    );

    _stompClient = StompClient(config: stompConfig);
    _stompClient.activate();
  }


  void onConnect(StompClient stompClient, StompFrame stompFrame, String destination) {
    print('Connected WebSocket');
    stompClient.subscribe(
      destination: destination,
      callback: (frame) {
        if (frame.body != null) {
          Map<String, dynamic> result = jsonDecode(frame.body!);
          _messageStreamController.add(result);
        }
      },
    );
  }

  Future<void> closeConnection() async {
    print('Disconnected WebSocket');
    _stompClient.deactivate();
  }

  Future<void> sendBid(Bid bid) async {
    final body = json.encode(Bid.fromJson(bid.toJson()));
    _stompClient.send(
      destination: '/app/bid',
      body: body,
    );
  }
}
