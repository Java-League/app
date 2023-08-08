import 'package:flutter/material.dart';
import 'package:java_league/components/overall.dart';
import 'package:java_league/models/player.dart';
import 'package:java_league/providers/auth_provider.dart';
import 'package:java_league/providers/theme_provider.dart';
import 'package:java_league/services/bid_service.dart';
import 'package:java_league/utils/formatter.dart';
import 'package:provider/provider.dart';

class PlayerListItem extends StatefulWidget {
  PlayerListItem({Key? key}) : super(key: key);

  @override
  State<PlayerListItem> createState() => _PlayerListItemState();
}

class _PlayerListItemState extends State<PlayerListItem> {
  final BidService _playerService = BidService();
  int _currentPrice = 0;

  @override
  void initState() {
    super.initState();
    _currentPrice = Provider.of<Player>(context, listen: false).price;
  }

  void _handleDecreasePrice() {
    setState(() {
      _currentPrice = _currentPrice - 100;
    });
  }

  void _handleIncreasePrice() {
    setState(() {
      _currentPrice = _currentPrice + 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    Player player = Provider.of<Player>(context);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);

    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 300),
      crossFadeState: !player.isUpdated ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      secondChild: cardMessage(player, authProvider.teamId),
      firstChild: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0)),
        ),
        elevation: 3,
        child: ExpansionTile(
          shape: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent, width: 1)),
          collapsedShape: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent, width: 1)),
          textColor: Theme.of(context).colorScheme.onSurfaceVariant,
          collapsedTextColor: Theme.of(context).colorScheme.onBackground,
          // leading: CircleAvatar(
          //   backgroundImage: NetworkImage(player.imageUrl),
          //   backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
          // ),
          trailing: Overall(overall: player.overall),
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(player.imageUrl),
                          backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 12),
                        Text(player.name),
                      ],
                    ),
                    Badge(
                      label: Text('Maior Lance', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.background)),
                      backgroundColor: Colors.green,
                      textColor: Colors.black,
                      isLabelVisible: authProvider.teamId == player.teamId,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      largeSize: 24,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [Text('Tempo Restante', style: TextStyle(fontSize: 14)), Text('3 Minutos', style: TextStyle(fontSize: 18))],
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            authProvider.teamId == player.teamId ? 'Meu Lance' : 'Lance Minímo',
                            style: TextStyle(fontSize: 14),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset(
                                themeProvider.isDark() ? 'assets/images/java_white.png' : 'assets/images/java_black.png',
                                width: 24,
                                fit: BoxFit.fitWidth,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                FormatterJavaLeague.formatarJavalis(authProvider.teamId == player.teamId ? player.price - 100 : player.price),
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    authProvider.teamId == player.teamId
                        ? Padding(
                            padding: const EdgeInsets.only(left: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('Meu Limite', style: TextStyle(fontSize: 14)),
                                Row(
                                  children: [
                                    Image.asset(
                                      themeProvider.isDark() ? 'assets/images/java_white.png' : 'assets/images/java_black.png',
                                      width: 24,
                                      fit: BoxFit.fitWidth,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(player.priceLimit != null ? FormatterJavaLeague.formatarJavalis(player.priceLimit) : '0.0', style: const TextStyle(fontSize: 18)),
                                  ],
                                )
                              ],
                            ),
                          )
                        : const SizedBox(height: 0),
                  ],
                ),
              ],
            ),
          ),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            authProvider.teamId != player.teamId
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Column(
                      children: [
                        InputDecorator(
                          decoration: InputDecoration(contentPadding: EdgeInsets.zero),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                color: Theme.of(context).colorScheme.onSecondaryContainer,
                                onPressed: _currentPrice > player.price ? _handleDecreasePrice : null,
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                ),
                                icon: Icon(Icons.remove),
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    themeProvider.isDark() ? 'assets/images/java_white.png' : 'assets/images/java_black.png',
                                    width: 24,
                                    fit: BoxFit.fitWidth,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    _currentPrice.toString(),
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              IconButton(
                                color: Theme.of(context).colorScheme.onSecondaryContainer,
                                onPressed: _handleIncreasePrice,
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                ),
                                icon: Icon(Icons.add),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _currentPrice >= player.price
                                    ? () {
                                        _playerService.bid(player.id, _currentPrice);
                                      }
                                    : null,
                                child: const Text('Dar Lance'),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Comprar agora por 200.000'),
                                    const SizedBox(width: 4),
                                    Image.asset(
                                      themeProvider.isDark() ? 'assets/images/java_white.png' : 'assets/images/java_black.png',
                                      width: 24,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : const SizedBox(height: 0),
          ],
        ),
      ),
    );
  }

  Widget cardMessage(Player player, int teamIdCurrent) {
    if (player.teamId == 0) return const CircularProgressIndicator();
    switch (player.message) {
      case 'FIRST_BID':
        if (player.teamId == teamIdCurrent) {
          return modelCard(message: 'Lance Realizado com Sucesso!', color: Colors.green, bidValue: player.price - 100);
        }
        return modelCardLoading();
      case 'HIGHEST_BID':
        if (player.teamId == teamIdCurrent) {
          return modelCard(message: 'Seu Lance superou o limite!', color: Colors.green, bidValue: player.price - 100);
        }
        if (player.teamIdLow == teamIdCurrent) {
          return modelCard(message: 'Seu Lance foi Superado!', color: Colors.red);
        }
        return modelCard(message: 'Lance minímo aumentado!', color: Colors.orangeAccent);
      case 'LOWEST_BID':
        if (!player.hasBidForTeam) return modelCardLoading();
        if (player.teamId == teamIdCurrent) {
          return modelCard(message: 'Ainda ganhando, mas seu Lance foi aumentado!', color: Colors.cyan, bidValue: player.price - 100);
        }
        if (player.teamIdLow == teamIdCurrent) {
          return modelCard(message: 'Já existe um lance maior!', color: Colors.red);
        }
        return modelCard(message: 'Lance minímo aumentado!', color: Colors.orangeAccent);
      default:
        return Card(
          color: Theme.of(context).colorScheme.background,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0)),
          ),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [CircularProgressIndicator()],
            ),
          ),
        );
    }
  }

  Widget modelCard({required String message, required Color color, int? bidValue}) {
    return Card(
      color: color,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                bidValue != null ? Text(FormatterJavaLeague.formatarJavalis(bidValue)) : const SizedBox(height: 0),
                Text(message),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget modelCardLoading () {
    return Card(
      color: Theme.of(context).colorScheme.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [CircularProgressIndicator()],
        ),
      ),
    );
  }
}
