import 'package:flutter/material.dart';
import 'package:java_league/models/jogadores.dart';
import 'package:provider/provider.dart';

class PlayerGridItem extends StatelessWidget {
  const PlayerGridItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final player = Provider.of<Jogador>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
            player.name,
            textAlign: TextAlign.center,
          ),
        ),
        child: GestureDetector(
          child: Image.network(
            player.imageUrl,
          ),
          // onTap: () {
          //   Navigator.of(context).pushNamed(
          //     AppRoutes.productDetail,
          //     arguments: player,
          //   );
          // },
        ),
      ),
    );
  }
}
