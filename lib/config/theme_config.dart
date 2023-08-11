import 'package:flutter/material.dart';

// https://m3.material.io/theme-builder#/custom
// Primary    HUE 230
// Secondary  HUE 180
// Tertiary   HUE 290

class ThemeConfig {
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF684FA4),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFE9DDFF),
    onPrimaryContainer: Color(0xFF23005C),
    secondary: Color(0xFF006685),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFBEE9FF),
    onSecondaryContainer: Color(0xFF001F2A),
    tertiary: Color(0xFF6C5E00),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFFBE366),
    onTertiaryContainer: Color(0xFF211B00),
    error: Color(0xFFBA1A1A),
    errorContainer: Color(0xFFFFDAD6),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFFFFBFF),
    onBackground: Color(0xFF1C1B1E),
    surface: Color(0xFFFFFBFF),
    onSurface: Color(0xFF1C1B1E),
    surfaceVariant: Color(0xFFE7E0EB),
    onSurfaceVariant: Color(0xFF49454E),
    outline: Color(0xFF7A757F),
    onInverseSurface: Color(0xFFF5EFF4),
    inverseSurface: Color(0xFF323033),
    inversePrimary: Color(0xFFD0BCFF),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF684FA4),
    outlineVariant: Color(0xFFCAC4CF),
    scrim: Color(0xFF000000),
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFD0BCFF),
    onPrimary: Color(0xFF381E72),
    primaryContainer: Color(0xFF50378A),
    onPrimaryContainer: Color(0xFFE9DDFF),
    secondary: Color(0xFF6BD3FF),
    onSecondary: Color(0xFF003546),
    secondaryContainer: Color(0xFF004D65),
    onSecondaryContainer: Color(0xFFBEE9FF),
    tertiary: Color(0xFFDDC74D),
    onTertiary: Color(0xFF383000),
    tertiaryContainer: Color(0xFF524700),
    onTertiaryContainer: Color(0xFFFBE366),
    error: Color(0xFFFFB4AB),
    errorContainer: Color(0xFF93000A),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color(0xFF1C1B1E),
    onBackground: Color(0xFFE6E1E6),
    surface: Color(0xFF1C1B1E),
    onSurface: Color(0xFFE6E1E6),
    surfaceVariant: Color(0xFF49454E),
    onSurfaceVariant: Color(0xFFCAC4CF),
    outline: Color(0xFF948F99),
    onInverseSurface: Color(0xFF1C1B1E),
    inverseSurface: Color(0xFFE6E1E6),
    inversePrimary: Color(0xFF684FA4),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFFD0BCFF),
    outlineVariant: Color(0xFF49454E),
    scrim: Color(0xFF000000),
  );

  static ThemeData ThemeLight() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: lightColorScheme,
      fontFamily: 'Lato',
      dividerTheme: DividerThemeData(
          color: lightColorScheme.surfaceVariant,
          thickness: 1,
          space: 1
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: lightColorScheme.onBackground),
        filled: true,
        fillColor: Colors.white10,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: lightColorScheme.outline,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: lightColorScheme.onBackground,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: lightColorScheme.error,
            width: 2,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 8,
          backgroundColor: lightColorScheme.secondaryContainer,
          foregroundColor: lightColorScheme.onSecondaryContainer,
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ),
      expansionTileTheme: ExpansionTileThemeData(
        shape: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent, width: 1)),
        collapsedShape: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent, width: 1)),
        textColor: lightColorScheme.onSurfaceVariant,
        collapsedTextColor: lightColorScheme.onBackground,
      ),
    );
  }

  static ThemeData ThemeDark() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme,
      fontFamily: 'Lato',
      dividerTheme: DividerThemeData(
        color: darkColorScheme.surfaceVariant,
        thickness: 1,
        space: 1
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: darkColorScheme.onBackground),
        filled: true,
        fillColor: Colors.white10,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: darkColorScheme.outline,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: darkColorScheme.onBackground,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: darkColorScheme.error,
            width: 2,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 8,
          backgroundColor: darkColorScheme.secondaryContainer,
          foregroundColor: darkColorScheme.onSecondaryContainer,
          // textStyle: const TextStyle(fontWeight: FontWeight.bold),
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ),
      expansionTileTheme: ExpansionTileThemeData(
        shape: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent, width: 1)),
        collapsedShape: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent, width: 1)),
        textColor: darkColorScheme.onSurfaceVariant,
        collapsedTextColor: darkColorScheme.onBackground,
      ),
    );
  }
}
