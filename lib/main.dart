import 'package:flutter/material.dart';
import 'package:java_league/pages/auth_or_home_page.dart';
import 'package:java_league/providers/auth_provider.dart';
import 'package:java_league/providers/jogador_provider.dart';
import 'package:java_league/providers/theme_provider.dart';
import 'package:java_league/providers/web_socket_provider.dart';
import 'package:java_league/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => WebSocketProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, JogadorProvider>(
          create: (_) => JogadorProvider([]),
          update: (ctx, auth, previous) {
            return JogadorProvider(
              previous?.items ?? [],
            );
          },
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) => MaterialApp(
          title: 'Flutter Demo',
          theme: themeProvider.getThemeData(),
          routes: {
            AppRoutes.AUTH_OR_HOME: (ctx) => const AuthOrHomePage(),
          },
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
