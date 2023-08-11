import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:java_league/components/circle_players.dart';
import 'package:java_league/components/gradiente_background.dart';
import 'package:java_league/components/overall.dart';
import 'package:java_league/components/soccer_field.dart';
import 'package:java_league/providers/player_provider.dart';
import 'package:provider/provider.dart';

class Formacao {
  String formacao;
  List<int> layout;

  Formacao({required this.formacao, required this.layout});
}

List<Formacao> list = [
  Formacao(formacao: '4-4-2', layout: [1, 4, 4, 2]),
  Formacao(formacao: '4-3-3', layout: [1, 4, 3, 3]),
  Formacao(formacao: '4-4-1', layout: [1, 4, 4, 1]),
  Formacao(formacao: '3-4-3', layout: [1, 3, 4, 3]),
  Formacao(formacao: '3-5-2', layout: [1, 3, 5, 2]),
  Formacao(formacao: '5-3-2', layout: [1, 5, 3, 2]),
  Formacao(formacao: '5-4-1', layout: [1, 5, 4, 1]),
];

class TeamPage extends StatefulWidget {
  const TeamPage({Key? key}) : super(key: key);

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  Formacao fomation = list.first;
  int position = 0;

  List<int> getFormationDigits() {
    return fomation.layout.reversed.map((digit) => digit).toList();
  }

  @override
  void initState() {
    super.initState();
    Provider.of<PlayerProvider>(context, listen: false).loadPlayers();
  }

  @override
  Widget build(BuildContext context) {
    List<int> formationDigits = getFormationDigits();
    double tamanho = 0.47 / formationDigits.length;

    return CarouselSlider(
      options: CarouselOptions(height: MediaQuery.of(context).size.height, viewportFraction: 1, enableInfiniteScroll: false),
      items: [
        Column(
          children: [
            Container(
              child: GradientBrackground(
                child: ExpansionTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Escalação'), Text(fomation.formacao)],
                  ),
                  children: filterFormation(),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.height * 0.5,
                      color: Colors.green,
                      // child: Image.asset('assets/images/campo.png'),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SoccerField(),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    for (int count in formationDigits)
                      SizedBox(
                        height: MediaQuery.of(context).size.height * tamanho,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: generateCircleAvatarsForRow(count),
                        ),
                      ),
                  ],
                )
              ],
            ),
            DropdownButton<Formacao>(
              value: fomation,
              icon: const Icon(Icons.keyboard_arrow_down),
              elevation: 16,
              onChanged: (Formacao? value) {
                // This is called when the user selects an item.
                setState(() {
                  fomation = value!;
                });
              },
              items: list.map<DropdownMenuItem<Formacao>>((value) {
                return DropdownMenuItem<Formacao>(
                  value: value,
                  child: Text(value.formacao),
                );
              }).toList(),
            ),
          ],
        ),
        ListPlayers(),
      ],
    );
  }

  List<Widget> filterFormation() {
    return [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Row(
            children: list.map((value) {
              return Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 8),
                child: ElevatedButton(onPressed: () {
                  setState(() {
                    fomation = value;
                  });
                }, child: Text(value.formacao)),
              );
            }).toList(),
          ),
        ),
      )
    ];
  }

  List<Widget> generateCircleAvatarsForRow(int count) {
    return List.generate(count, (index) {
      position++;
      return CirclePlayer(position: position);
    });
  }

  Widget ListPlayers() {
    return SizedBox(
      child: ListView(
        children: [
          const GradientBrackground(
            child: ListTile(
              title: Text('Goleiros', textAlign: TextAlign.center),
            ),
          ),
          ListTile(
            leading: GradientBrackground(
              shape: BoxShape.circle,
              child: ClipOval(
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(Colors.grey, BlendMode.saturation),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://cdn.sofifa.net/players/212/831/23_60.png',
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
            ),
            title: Text('Alisson'),
            trailing: Overall(overall: 90),
          ),
          ListTile(
            leading: GradientBrackground(
              shape: BoxShape.circle,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://cdn.sofifa.net/players/210/257/23_60.png',
                ),
                backgroundColor: Colors.transparent,
              ),
            ),
            title: Text('Ederson'),
            trailing: Overall(overall: 89),
          ),
          const GradientBrackground(
            child: ListTile(
              title: Text('Defensores', textAlign: TextAlign.center),
            ),
          ),
          ListTile(
            leading: GradientBrackground(
              shape: BoxShape.circle,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://cdn.sofifa.net/players/203/376/23_60.png',
                ),
                backgroundColor: Colors.transparent,
              ),
            ),
            title: Text('V. van Dijk'),
            trailing: Overall(overall: 90),
          ),
          ListTile(
            leading: GradientBrackground(
              shape: BoxShape.circle,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://cdn.sofifa.net/players/212/622/23_60.png',
                ),
                backgroundColor: Colors.transparent,
              ),
            ),
            title: Text('J. Kimmich'),
            trailing: Overall(overall: 89),
          ),
          ListTile(
            leading: GradientBrackground(
              shape: BoxShape.circle,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://cdn.sofifa.net/players/205/452/23_60.png',
                ),
                backgroundColor: Colors.transparent,
              ),
            ),
            title: Text('A. Rüdiger'),
            trailing: Overall(overall: 87),
          ),
          ListTile(
            leading: GradientBrackground(
              shape: BoxShape.circle,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://cdn.sofifa.net/players/201/024/23_60.png',
                ),
                backgroundColor: Colors.transparent,
              ),
            ),
            title: Text('K. Koulibaly'),
            trailing: Overall(overall: 87),
          ),
          const GradientBrackground(
            child: ListTile(
              title: Text('Meias', textAlign: TextAlign.center),
            ),
          ),
          ListTile(
            title: Text('Alisson'),
          ),
          ListTile(
            title: Text('Alisson'),
          ),
          ListTile(
            title: Text('Alisson'),
          ),
          ListTile(
            title: Text('Alisson'),
          ),
          const GradientBrackground(
            child: ListTile(
              title: Text('Atacantes', textAlign: TextAlign.center),
            ),
          ),
          ListTile(
            title: Text('Alisson'),
          ),
          ListTile(
            title: Text('Alisson'),
          ),
        ],
      ),
    );
  }
}
