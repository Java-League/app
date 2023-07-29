import 'package:flutter/material.dart';
import 'package:java_league/config/theme_config.dart';

enum ThemeType { Light, Dark }

class ThemeProvider with ChangeNotifier {
  ThemeType _currentTheme = ThemeType.Light;

  ThemeType get currentTheme => _currentTheme;

  void toggleTheme() {
    _currentTheme = _currentTheme == ThemeType.Light ? ThemeType.Dark : ThemeType.Light;
    notifyListeners();
  }

  bool isDark() {
    return _currentTheme == ThemeType.Light;
  }

  ThemeData getThemeData() {
    return _currentTheme == ThemeType.Light ? ThemeConfig.ThemeLight() : ThemeConfig.ThemeDark();
  }
}