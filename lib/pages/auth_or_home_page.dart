import 'package:flutter/material.dart';
import 'package:java_league/pages/auth_page.dart';
import 'package:java_league/pages/home_page.dart';
import 'package:java_league/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class AuthOrHomePage extends StatelessWidget {
  const AuthOrHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    return auth.isAuth ? HomePage() : AuthPage();
  }
}
