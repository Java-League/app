import 'package:flutter/material.dart';

class ThemeConfig {
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF006686),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFC0E8FF),
    onPrimaryContainer: Color(0xFF001E2B),
    secondary: Color(0xFF006B5C),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFF77F8DF),
    onSecondaryContainer: Color(0xFF00201B),
    tertiary: Color(0xFF5E5A7D),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFE4DFFF),
    onTertiaryContainer: Color(0xFF1B1736),
    error: Color(0xFFBA1A1A),
    errorContainer: Color(0xFFFFDAD6),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFFBFCFE),
    onBackground: Color(0xFF191C1E),
    surface: Color(0xFFFBFCFE),
    onSurface: Color(0xFF191C1E),
    surfaceVariant: Color(0xFFDCE3E9),
    onSurfaceVariant: Color(0xFF40484C),
    outline: Color(0xFF71787D),
    onInverseSurface: Color(0xFFF0F1F3),
    inverseSurface: Color(0xFF2E3133),
    inversePrimary: Color(0xFF70D2FF),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF006686),
    outlineVariant: Color(0xFFC0C7CD),
    scrim: Color(0xFF000000),
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF70D2FF),
    onPrimary: Color(0xFF003547),
    primaryContainer: Color(0xFF004D66),
    onPrimaryContainer: Color(0xFFC0E8FF),
    secondary: Color(0xFF57DBC3),
    onSecondary: Color(0xFF00382F),
    secondaryContainer: Color(0xFF005045),
    onSecondaryContainer: Color(0xFF77F8DF),
    tertiary: Color(0xFFC8C2EA),
    onTertiary: Color(0xFF302D4C),
    tertiaryContainer: Color(0xFF464364),
    onTertiaryContainer: Color(0xFFE4DFFF),
    error: Color(0xFFFFB4AB),
    errorContainer: Color(0xFF93000A),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color(0xFF191C1E),
    onBackground: Color(0xFFE1E2E5),
    surface: Color(0xFF191C1E),
    onSurface: Color(0xFFE1E2E5),
    surfaceVariant: Color(0xFF40484C),
    onSurfaceVariant: Color(0xFFC0C7CD),
    outline: Color(0xFF8A9297),
    onInverseSurface: Color(0xFF191C1E),
    inverseSurface: Color(0xFFE1E2E5),
    inversePrimary: Color(0xFF006686),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF70D2FF),
    outlineVariant: Color(0xFF40484C),
    scrim: Color(0xFF000000),
  );

  static ThemeData ThemeLight() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: lightColorScheme,
      fontFamily: 'Lato',
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
    );
  }

  static ThemeData ThemeDark() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme,
      fontFamily: 'Lato',
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
    );
  }
}
