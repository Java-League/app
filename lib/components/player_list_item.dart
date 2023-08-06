import 'package:flutter/material.dart';
import 'package:java_league/components/overall.dart';
import 'package:java_league/models/bid.dart';
import 'package:java_league/models/player.dart';
import 'package:java_league/providers/theme_provider.dart';
import 'package:java_league/services/bid_service.dart';
import 'package:java_league/utils/formatter.dart';
import 'package:provider/provider.dart';

class PlayerListItem extends StatefulWidget {
  final Player player;
  final bool isUpdated;

  PlayerListItem(this.player, {required this.isUpdated, Key? key}) : super(key: key);

  @override
  State<PlayerListItem> createState() => _PlayerListItemState();
}

class _PlayerListItemState extends State<PlayerListItem> {
  final BidService _bidService = BidService();
  bool _isExpanded = false;


  int _currentPrice = 0;
  int _minimumPrice = 0;

  @override
  void initState() {
    super.initState();
    _currentPrice = widget.player.price.toInt();
    _minimumPrice = widget.player.price.toInt();
  }

  void _handleDecreasePrice() {
    setState(() {
      _currentPrice = _currentPrice - 250;
      if (_currentPrice < _minimumPrice) {
        _currentPrice = _minimumPrice;
      }
    });
  }

  void _handleIncreasePrice(int amount) {
    setState(() {
      _currentPrice = _currentPrice + amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 300),
      crossFadeState: !widget.isUpdated ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      secondChild: Card(
        color: Colors.green,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0)),
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [Text('Lance realizado com Sucesso!')],
          ),
        ),
      ),
      firstChild: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0)),
        ),
        elevation: 3,
        child: ExpansionTile(
          initiallyExpanded: false,
          shape: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent, width: 1)),
          collapsedShape: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent, width: 1)),
          textColor: Theme.of(context).colorScheme.onSurfaceVariant,
          collapsedTextColor: Theme.of(context).colorScheme.onBackground,
          onExpansionChanged: (val) => setState(() {
            _isExpanded = val;
          }),
          // leading: CircleAvatar(
          //   backgroundImage: NetworkImage(player.imageUrl),
          //   backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
          // ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Overall(overall: widget.player.overall),
            ],
          ),
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(widget.player.name),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [Text('Tempo Restante', style: TextStyle(fontSize: 14)), Text('3 Minutos', style: TextStyle(fontSize: 18))],
                        ),
                        const SizedBox(width: 32),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Lance Atual', style: TextStyle(fontSize: 14)),
                            Row(
                              children: [
                                Image.asset(
                                  themeProvider.isDark() ? 'assets/images/java_white.png' : 'assets/images/java_black.png',
                                  width: 24,
                                  fit: BoxFit.fitWidth,
                                ),
                                const SizedBox(width: 4),
                                Text(FormatterJavaLeague.formatarJavalis(widget.player.price), style: TextStyle(fontSize: 18)),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
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
                          onPressed: _currentPrice > _minimumPrice ? _handleDecreasePrice : null,
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
                          Text(_currentPrice.toString(), style: TextStyle(fontSize: 20),),

                          ],
                        ),
                        IconButton(
                          color: Theme.of(context).colorScheme.onSecondaryContainer,
                          onPressed: () => _handleIncreasePrice(250),
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
                          onPressed: _currentPrice > _minimumPrice ? () {
                            _bidService.bid(Bid(bidValue: _currentPrice.toDouble(), userId: 1, playerId: widget.player.id));

                          } : null ,
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
            ),
          ],
        ),
      ),
    );
  }
}
