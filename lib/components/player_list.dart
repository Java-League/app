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

  @override
  void initState() {
    super.initState();

    final webSocketProvider = Provider.of<WebSocketProvider>(context, listen: false);
    webSocketProvider.initConnection('/topic/bid');

    webSocketProvider.messageStream.listen((snapshot) {
      if (snapshot != null) {
        final updatedPlayerId = snapshot['playerId'];
        final updatedPlayerPrice = snapshot['newPrice'];
        final teamIdHighest = snapshot['teamIdHighest'];
        final teamIdLowest = snapshot['teamIdLowest'];
        final message = snapshot['message'];
        final priceLimit = snapshot['priceLimit'];

        // Encontre o player na lista e atualize seu preço.
        final updatedPlayerIndex = loadedPlayers.indexWhere((player) => player.id == updatedPlayerId);
        if (updatedPlayerIndex != -1) {
          if (mounted) {
            setState(() {
              loadedPlayers[updatedPlayerIndex].hasBidForTeam = true;
              loadedPlayers[updatedPlayerIndex].thisUpdated(updatedPlayerPrice, teamIdHighest, teamIdLowest ?? 0, message, priceLimit);
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
      itemCount: loadedPlayers.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: loadedPlayers[index],
        child: PlayerListItem(),
      ),
    );
  }
}
