import 'package:flutter/material.dart';
import 'package:java_league/components/player_list_item.dart';
import 'package:java_league/models/player.dart';
import 'package:java_league/providers/player_provider.dart';
import 'package:provider/provider.dart';

import '../providers/web_socket_provider.dart';

class PlayerList extends StatefulWidget {

  const PlayerList({Key? key}) : super(key: key);

  @override
  State<PlayerList> createState() => _PlayerListState();
}

class _PlayerListState extends State<PlayerList> {
  List<Player> loadedPlayers = [];
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
        final updatedPlayerPrice = snapshot['newPrice'];

        // Encontre o player na lista e atualize seu preço.
        final updatedPlayerIndex = loadedPlayers.indexWhere((player) => player.id == updatedPlayerId);
        if (updatedPlayerIndex != -1) {
          if (mounted) {
            setState(() {
              loadedPlayers[updatedPlayerIndex].price = updatedPlayerPrice;
              _updatedPlayerId = updatedPlayerId;
              _isPlayerUpdated = true;
            });

            Future.delayed(Duration(seconds: 3), () {
              if (mounted) {
                setState(() {
                  _isPlayerUpdated = false;
                });
              }
            });
          }
        }
      }
    });
  }

  @override
  void deactivate() {
    Provider.of<WebSocketProvider>(context, listen: false).closeConnection();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlayerProvider>(context);
    loadedPlayers = provider.players;

    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final player = loadedPlayers[index];
        return PlayerListItem(
          player,
          isUpdated: player.id == _updatedPlayerId && _isPlayerUpdated,
        );
      },
      itemCount: loadedPlayers.length,
    );
  }
}