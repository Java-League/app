import 'package:flutter/material.dart';
import 'package:java_league/components/gradiente_background.dart';
import 'package:java_league/components/player_list.dart';
import 'package:java_league/providers/player_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

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
  SfRangeValues _values = SfRangeValues(40, 80);
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
    return Column(
      children: [
        GradientBrackground(
          child: ExpansionTile(
            title: Text('Lista de Jogadores'),
            trailing: Icon(Icons.tune),
            children: [
              filter(),
            ],
          ),
        ),
        _isLoading ? const Expanded(child: Center(child: CircularProgressIndicator())) : const Expanded(child: PlayerList()),
      ],
    );
  }

  Widget filter() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              labelText: 'Nome',
            ),
            obscureText: true,
          ),
          SfRangeSlider(
            min: 0,
            max: 100,
            values: _values,
            interval: 20,
            showTicks: true,
            showLabels: true,
            enableTooltip: true,
            tooltipTextFormatterCallback: (dynamic actualValue, String formattedText) {
              return actualValue.toStringAsFixed(0);
            },
            onChanged: (SfRangeValues values){
              setState(() {
                _values = values;
              });
            },
          ),
          ListTile(
            title: Text('Filter 3'),
          ),
          ListTile(
            title: Text('Filter 4'),
          ),
        ],
      ),
    );
  }
}
