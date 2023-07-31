import 'package:flutter/material.dart';
import 'package:java_league/config/theme_config.dart';

enum ThemeType { Light, Dark }

class ThemeProvider with ChangeNotifier {
  ThemeType _currentTheme = ThemeType.Dark;

  ThemeType get currentTheme => _currentTheme;

  void toggleTheme() {
    _currentTheme = _currentTheme == ThemeType.Dark ? ThemeType.Light : ThemeType.Dark;
    notifyListeners();
  }

  bool isDark() {
    return _currentTheme == ThemeType.Dark;
  }

  ThemeData getThemeData() {
    return _currentTheme == ThemeType.Dark ? ThemeConfig.ThemeDark() : ThemeConfig.ThemeLight();
  }
}