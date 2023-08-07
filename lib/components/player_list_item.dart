import 'package:flutter/material.dart';
import 'package:java_league/components/overall.dart';
import 'package:java_league/models/player.dart';
import 'package:java_league/providers/auth_provider.dart';
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
  final BidService _playerService = BidService();
  int _currentPrice = 0;

  @override
  void initState() {
    super.initState();
    _currentPrice = widget.player.price.toInt();
  }

  void _handleDecreasePrice() {
    setState(() {
      _currentPrice = _currentPrice - 100;
      if (_currentPrice < widget.player.price) {
        _currentPrice = widget.player.price;
      }
    });
  }

  void _handleIncreasePrice() {
    setState(() {
      _currentPrice = _currentPrice + 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
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
          shape: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent, width: 1)),
          collapsedShape: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent, width: 1)),
          textColor: Theme.of(context).colorScheme.onSurfaceVariant,
          collapsedTextColor: Theme.of(context).colorScheme.onBackground,
          // leading: CircleAvatar(
          //   backgroundImage: NetworkImage(widget.player.imageUrl),
          //   backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
          // ),
          trailing: Overall(overall: widget.player.overall),
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
                          backgroundImage: NetworkImage(widget.player.imageUrl),
                          backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 12),
                        Text(widget.player.name),
                      ],
                    ),
                    Badge(
                      label: const Text('Vencendo'),
                      backgroundColor: Colors.green,
                      textColor: Colors.black,
                      isLabelVisible: authProvider.teamId == widget.player.teamId,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [Text('Tempo Restante', style: TextStyle(fontSize: 14)), Text('3 Minutos', style: TextStyle(fontSize: 18))],
                      ),
                    ),
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
                    authProvider.teamId == widget.player.teamId ?
                    Column(
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
                            Text('0.0', style: TextStyle(fontSize: 18)),
                          ],
                        )
                      ],
                    ) : const SizedBox(height: 0),
                  ],
                ),
              ],
            ),
          ),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            authProvider.teamId != widget.player.teamId ? Padding(
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
                          onPressed: _currentPrice > widget.player.price ? _handleDecreasePrice : null,
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
                          onPressed: _currentPrice > widget.player.price ? () {
                            // Provider.of<WebSocketProvider>(context, listen: false).sendBid(Bid(value: _currentPrice, playerId: widget.player.id));
                            _playerService.bid(widget.player.id, _currentPrice);
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
            ) : const SizedBox(height: 0),
          ],
        ),
      ),
    );
  }
}
