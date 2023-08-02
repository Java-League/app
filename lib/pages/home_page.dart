import 'package:flutter/material.dart';
import 'package:java_league/pages/bid_page.dart';
import 'package:java_league/providers/auth_provider.dart';
import 'package:java_league/providers/theme_provider.dart';
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
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('Real Madrid FC'),
            Text(
              'J\$ 25.000',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.secondaryContainer,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: _pages(context)[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        elevation: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.feed),
            label: 'Meus Lances',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Leilão',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Meu Time',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.onSecondaryContainer,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

List<Widget> _pages(BuildContext context) {
  return [
    SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // FeedBid()
            Text('Lances')
          ],
        ),
      ),
    ),
    BidPage(),
    SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // FeedBid()
            Text('Meu Time')
          ],
        ),
      ),
    ),
  ];
}

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Real Madrid FC', style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer)),
            accountEmail: Text('Técnico: Yan Willian', style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer)),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: NetworkImage('https://cdn.sofifa.net/meta/team/3468/120.png'),
              backgroundColor: Colors.transparent,
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context).colorScheme.secondaryContainer,
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {

            },
          ),
          ListTile(
            leading: Icon(Icons.store),
            title: Text('Leilão'),
            onTap: () {
              // Implemente a ação ao clicar no item do menu
              // Ex: Navigator.pop(context); // Fecha o menu lateral
            },
          ),
          ListTile(
            leading: Icon(Icons.feed),
            title: Text('Meu Time'),
            onTap: () {
              // Implemente a ação ao clicar no item do menu
              // Ex: Navigator.pop(context); // Fecha o menu lateral
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configurações'),
            onTap: () {
              // Implemente a ação ao clicar no item do menu
              // Ex: Navigator.pop(context); // Fecha o menu lateral
            },
          ),
          ListTile(
            title: IconButton(
              onPressed: () => themeProvider.toggleTheme(),
              icon: themeProvider.isDark() ? const Icon(Icons.light_mode) : const Icon(Icons.dark_mode),
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Sair'),
            onTap: () {
              Navigator.pop(context);
              Provider.of<AuthProvider>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
