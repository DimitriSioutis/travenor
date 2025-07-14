import 'package:flutter/material.dart';
import 'package:travenor/src/extensions/color_scheme_extension.dart';
import 'package:travenor/src/utils/theme/custom_themes/text_theme.dart';
import 'custom_themes/color_scheme.dart';

class AppTheme {
  AppTheme._();

  static const Color _fadeLightGreyColor = Color(0xFFF7F7F9);
  static const Color _grey = Color(0xFF7D848D);
  static const Color _fadeDarkGreyColor = Color(0xFF2A2A32);
  static const Color _darkGrey = Color(0xFF8A8A8F);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'sf',
    brightness: Brightness.light,
    // primaryColor: mainColor,
    // scaffoldBackgroundColor: lightBgColor,
    textTheme: AppTextTheme.lightTextTheme,
    colorScheme: AppColorScheme.lightColorScheme,
    extensions: <ThemeExtension<dynamic>>[
      const CustomColorsExtension(onSurfaceSecondary: _grey, onSurfaceBlock: _fadeLightGreyColor),
    ],
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'sf',
    brightness: Brightness.dark,
    // primaryColor: mainColor,
    // scaffoldBackgroundColor: darkBgColor,
    textTheme: AppTextTheme.darkTextTheme,
    colorScheme: AppColorScheme.darkColorScheme,
    extensions: <ThemeExtension<dynamic>>[
      const CustomColorsExtension(onSurfaceSecondary: _darkGrey, onSurfaceBlock: _fadeDarkGreyColor),
    ],
  );
}
