import 'package:flutter/material.dart';
import 'package:java_league/components/overall.dart';
import 'package:java_league/models/jogadores.dart';
import 'package:provider/provider.dart';

class PlayerGridItem extends StatelessWidget {
  const PlayerGridItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final player = Provider.of<Jogador>(context, listen: false);

    return ListTile(
      leading: Image.network(player.imageUrl),
      title: Text(player.name),
      subtitle: Text(player.price.toString()),
      trailing: Overall(overall: player.overall),
    );

  }
}
