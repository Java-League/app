import 'package:flutter/material.dart';
import 'package:java_league/pages/auth_page.dart';
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
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) => MaterialApp(
          title: 'Flutter Demo',
          theme: themeProvider.getThemeData(),
          routes: {
            AppRoutes.auth: (ctx) => const AuthPage(),
          },
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
