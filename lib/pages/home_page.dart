import 'package:flutter/material.dart';
import 'package:java_league/components/gradiente_background.dart';
import 'package:java_league/pages/bid_page.dart';
import 'package:java_league/pages/feed_page.dart';
import 'package:java_league/pages/team_page.dart';
import 'package:java_league/pages/select_team.dart';
import 'package:java_league/providers/auth_provider.dart';
import 'package:java_league/providers/theme_provider.dart';
import 'package:java_league/utils/formatter.dart';
import 'package:provider/provider.dart';

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
    Provider.of<AuthProvider>(context, listen: false).getCurrentTeam();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    if (authProvider.team == null) {
      return const SelectTeam();
    }
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        flexibleSpace: const GradientBrackground(),
        leading: Builder(
          builder: (context) => IconButton(
            icon: CircleAvatar(child: Image.network(authProvider.team!.emblem, width: 32)),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(authProvider.team!.name),
            Row(
              children: [
                Image.asset(
                  themeProvider.isDark() ? 'assets/images/java_white.png' : 'assets/images/java_black.png',
                  width: 24,
                  fit: BoxFit.fitWidth,
                ),
                const SizedBox(width: 8),
                Text(
                  FormatterJavaLeague.formatarJavalis(authProvider.team!.javalis),
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
      body: _pages(context)[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 7,
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
    const FeedPage(),
    const BidPage(),
    const TeamPage(),
  ];
}

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(authProvider.team!.name, style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer)),
            accountEmail: Text('Técnico: Yan Willian', style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer)),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(authProvider.team!.emblem),
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
            onTap: () {},
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
            leading: themeProvider.isDark() ? const Icon(Icons.dark_mode) : const Icon(Icons.light_mode),
            title: Text('Alterar Tema'),
            onTap: () {
              themeProvider.toggleTheme();
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Sair'),
            onTap: () {
              Navigator.pop(context);
              Provider.of<AuthProvider>(context, listen: false).logout();
            },
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(authProvider.team!.uniform1),
                Image.network(authProvider.team!.uniform2),
              ],
            ),
          )
        ],
      ),
    );
  }
}
