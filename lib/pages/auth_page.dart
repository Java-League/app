import 'package:flutter/material.dart';
import 'package:java_league/components/auth_form.dart';
import 'package:java_league/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

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
                        width: MediaQuery.of(context).size.width * 0.45,
                        fit: BoxFit.fitWidth,
                      ),
                      const SizedBox(height: 24),
                      const AuthForm(),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          themeProvider.toggleTheme();
                        },
                        child: const Text('Trocar Tema'),
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
}
