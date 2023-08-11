import 'package:flutter/material.dart';
import 'package:java_league/components/gradiente_background.dart';
import 'package:java_league/components/popover_list_players.dart';
import 'package:java_league/services/team_service.dart';
import 'package:popover/popover.dart';

class CirclePlayer extends StatelessWidget {
  final int? position;

  const CirclePlayer({this.position, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GestureDetector(
        child: GradientBrackground(
          shape: BoxShape.circle,
          child: CircleAvatar(
            // backgroundImage: position == null ? null : NetworkImage(Provider.of<PlayerProvider>(context).players[position!].imageUrl),
            child: const Icon(Icons.person),
            backgroundColor: Colors.transparent,
          ),
        ),
        onTap: () {
          showPopover(
            context: context,
            bodyBuilder: (context) => const ListItems(),
            direction: PopoverDirection.bottom,
            backgroundColor: Theme.of(context).colorScheme.background,
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.4,
            arrowHeight: 15,
            arrowWidth: 15,
          ).then((value) {
            if (value != null && position != null) {
              TeamService().saveTeamPlayer(value as int, position!);
            }
          });
        },
      ),
    );
  }
}