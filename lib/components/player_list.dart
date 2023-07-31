import 'package:flutter/material.dart';
import 'package:java_league/components/player_list_item.dart';
import 'package:java_league/models/jogadores.dart';
import 'package:java_league/providers/jogador_provider.dart';
import 'package:provider/provider.dart';

class PlayerList extends StatelessWidget {
  final bool showFavoriteOnly;

  const PlayerList(this.showFavoriteOnly, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<JogadorProvider>(context);
    final List<Jogador> loadedProducts =
        showFavoriteOnly ? provider.favoriteItems : provider.items;

    return ListView.builder(
      itemCount: loadedProducts.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: loadedProducts[i],
        child: PlayerListItem(),
      ),
    );
  }
}
