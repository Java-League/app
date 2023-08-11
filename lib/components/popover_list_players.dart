import 'package:flutter/material.dart';
import 'package:java_league/components/overall.dart';
import 'package:java_league/providers/player_provider.dart';
import 'package:provider/provider.dart';

class ListItems extends StatelessWidget {
  const ListItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlayerProvider playerProvider = Provider.of<PlayerProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: playerProvider.players.map((value) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(value.imageUrl),
              backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            title: Text(value.name),
            trailing: Overall(overall: value.overall),
            onTap: () {
              Navigator.pop(context, value.id);
            },
          );
        }).toList(),
      ),
    );
  }
}