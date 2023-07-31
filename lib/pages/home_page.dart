import 'package:flutter/material.dart';
import 'package:java_league/components/player_list.dart';
import 'package:java_league/providers/jogador_provider.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  favorite,
  all,
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showFavoriteOnly = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<JogadorProvider>(
      context,
      listen: false,
    ).loadPlayers().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        elevation: 0,
        title: const Text('Home Page'),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.favorite,
                child: Text('Somente Favoritos'),
              ),
              const PopupMenuItem(
                value: FilterOptions.all,
                child: Text('Todos'),
              ),
            ],
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.favorite) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
              });
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Theme.of(context).colorScheme.secondaryContainer,
                      Theme.of(context).colorScheme.primaryContainer,
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  ),
                ),
                PlayerList(_showFavoriteOnly),
              ],
            ),
    );
  }
}
