import 'package:flutter/material.dart';
import 'package:java_league/components/overall.dart';
import 'package:java_league/models/jogadores.dart';
import 'package:java_league/utils/formatter.dart';
import 'package:provider/provider.dart';

class PlayerListItem extends StatelessWidget {
  const PlayerListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final player = Provider.of<Jogador>(context, listen: false);

    return ExpansionTile(
      shape: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent, width: 1)),
      collapsedShape: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent, width: 1)),
      textColor: Theme.of(context).colorScheme.onSurfaceVariant,
      collapsedTextColor: Theme.of(context).colorScheme.onBackground,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(player.imageUrl),
        backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(player.name),
                Text('Lance Atual   ${FormatterJavaLeague.formatarJavalis(player.price)}'),
              ],
            ),
            Overall(overall: player.overall)
          ],
        ),
      ),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            children: [
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Valor Inicial: ${FormatterJavaLeague.formatarJavalis(player.price)}'),
                        Text('Posição: ST RW'),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: player.isFavorite
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : const Icon(Icons.favorite_border),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Row(
                children: const [
                  Text('Lance por: Real Madrid FC'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('J\$ 23.000,00'),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        ),
                        child: const Text('+ 250'),
                      ),
                      const SizedBox(width: 4),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        ),
                        child: const Text('+ 500'),
                      ),
                      const SizedBox(width: 4),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        ),
                        child: const Text('+ 1000'),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),

      ],
    );
  }
}
