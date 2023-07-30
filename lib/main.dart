import 'package:flutter/material.dart';
import 'package:java_league/pages/auth_or_home_page.dart';
import 'package:java_league/providers/auth_provider.dart';
import 'package:java_league/providers/theme_provider.dart';
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
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
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
