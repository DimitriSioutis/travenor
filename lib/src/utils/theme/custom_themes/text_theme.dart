import 'package:flutter/material.dart';

class AppTextTheme {
  AppTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
    displayMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
    displaySmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),

    headlineLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    headlineMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    headlineSmall: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),

    titleLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),

    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    bodySmall: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),

    labelLarge: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
    labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
    labelSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
  );

  static const TextTheme darkTextTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
    displayMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
    displaySmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),

    headlineLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    headlineMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    headlineSmall: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),

    titleLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),

    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    bodySmall: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),

    labelLarge: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
    labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
    labelSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
  );
}
