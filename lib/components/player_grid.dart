import 'package:flutter/material.dart';
import 'package:java_league/components/player_grid_item.dart';
import 'package:java_league/models/jogadores.dart';
import 'package:java_league/providers/jogador_provider.dart';
import 'package:provider/provider.dart';

class PlayerGrid extends StatelessWidget {
  final bool showFavoriteOnly;

  const PlayerGrid(this.showFavoriteOnly, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<JogadorProvider>(context);
    final List<Jogador> loadedProducts =
        showFavoriteOnly ? provider.favoriteItems : provider.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: loadedProducts[i],
        child: const PlayerGridItem(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
