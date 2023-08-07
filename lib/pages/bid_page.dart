import 'package:flutter/material.dart';
import 'package:java_league/components/player_list.dart';
import 'package:java_league/providers/player_provider.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  favorite,
  all,
}

class BidPage extends StatefulWidget {
  const BidPage({Key? key}) : super(key: key);

  @override
  State<BidPage> createState() => _BidPageState();
}

class _BidPageState extends State<BidPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<PlayerProvider>(
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
      return _isLoading
          ? const Center(child: CircularProgressIndicator())
          : PlayerList();
  }
}
