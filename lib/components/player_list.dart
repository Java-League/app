import 'package:flutter/material.dart';
import 'package:java_league/components/player_list_item.dart';
import 'package:java_league/models/player.dart';
import 'package:java_league/providers/jogador_provider.dart';
import 'package:provider/provider.dart';

import '../providers/web_socket_provider.dart';

class PlayerList extends StatefulWidget {

  const PlayerList({Key? key}) : super(key: key);

  @override
  State<PlayerList> createState() => _PlayerListState();
}

class _PlayerListState extends State<PlayerList> {
  List<Player> loadedProducts = [];
  int? _updatedPlayerId;
  bool _isPlayerUpdated = false;

  @override
  void initState() {
    super.initState();

    final webSocketProvider = Provider.of<WebSocketProvider>(context, listen: false);
    webSocketProvider.initConnection('/topic/bid');

    webSocketProvider.messageStream.listen((snapshot) {
      if (snapshot != null) {
        final updatedPlayerId = snapshot['playerId'];
        final updatedPlayerPrice = snapshot['bidValue'];

        // Encontre o player na lista e atualize seu preço.
        final updatedPlayerIndex = loadedProducts.indexWhere((player) => player.id == updatedPlayerId);
        if (updatedPlayerIndex != -1) {
          setState(() {
            loadedProducts[updatedPlayerIndex].price = updatedPlayerPrice;
            _updatedPlayerId = updatedPlayerId;
            _isPlayerUpdated = true;
          });

          Future.delayed(Duration(seconds: 3), () {
            setState(() {
              _isPlayerUpdated = false;
            });
          });
        }
      }
    });
  }

  @override
  void dispose() {
    final webSocketProvider = Provider.of<WebSocketProvider>(context, listen: false);
    webSocketProvider.closeConnection();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<JogadorProvider>(context);
    loadedProducts = provider.items;

    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final player = loadedProducts[index];
        return PlayerListItem(
          player,
          isUpdated: player.id == _updatedPlayerId && _isPlayerUpdated,
        );
      },
      itemCount: loadedProducts.length,
    );
  }
}