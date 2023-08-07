import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:java_league/models/team.dart';
import 'package:java_league/providers/theme_provider.dart';
import 'package:java_league/services/team_service.dart';
import 'package:provider/provider.dart';

class SelectTeam extends StatefulWidget {
  const SelectTeam({Key? key}) : super(key: key);

  @override
  State<SelectTeam> createState() => _SelectTeamState();
}

class _SelectTeamState extends State<SelectTeam> {
  List<Team> teams = [];

  @override
  void initState() {
    TeamService().getAllTeamsAvailable().then((value) {
      setState(() {
        teams = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.secondaryContainer,
                Theme.of(context).colorScheme.primaryContainer,
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              reverse: true,
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        themeProvider.isDark() ? 'assets/images/java_league_logo_white.png' : 'assets/images/java_league_logo_black.png',
                        width: MediaQuery.of(context).size.width * 0.30,
                        fit: BoxFit.fitWidth,
                      ),
                      const SizedBox(height: 24),
                      CarouselSlider(
                        options: CarouselOptions(height: MediaQuery.of(context).size.height * 0.5, viewportFraction: 0.8),
                        items: teams.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Card(
                                elevation: 15,
                                color: Colors.transparent,
                                margin: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: team(i),
                              );
                            },
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget team(Team team) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          team.name,
          style: const TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(team.emblem),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(team.uniform1),
            Image.network(team.uniform2),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ElevatedButton(onPressed: () {}, child: const Text('Selecionar Time'))],
        )
      ],
    );
  }
}
