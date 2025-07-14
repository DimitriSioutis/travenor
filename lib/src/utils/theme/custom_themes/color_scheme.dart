import 'package:flutter/material.dart';

class AppColorScheme {
  AppColorScheme._();

  static const Color _mainColor = Color(0xFF24BAEC);
  static const Color _secondaryColor = Color(0xFFFF7029);
  // Light theme colors

  static const Color _lightBgColor = Color(0xFFFFFFFF);
  static const Color _whiteText = Color(0xFFE4E4E6);
  // Dark theme colors
  static const Color _blackText = Color(0xFF1B1E28);
  static const Color _darkBgColor = Color(0xFF1C1C23);

  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: _mainColor,
    onPrimary: Colors.white,
    secondary: _secondaryColor,
    onSecondary: Colors.white,
    error: Colors.redAccent,
    onError: Colors.white,
    surface: _lightBgColor,
    onSurface: _blackText,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: _mainColor,
    onPrimary: Colors.white,
    secondary: _secondaryColor,
    onSecondary: Colors.white,
    error: Colors.redAccent,
    onError: Colors.white,
    surface: _darkBgColor,
    onSurface: _whiteText,
  );
}
