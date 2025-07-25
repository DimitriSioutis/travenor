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

    textTheme: AppTextTheme.lightTextTheme,
    colorScheme: AppColorScheme.lightColorScheme,
    extensions: <ThemeExtension<dynamic>>[
      const CustomColorsExtension(onSurfaceSecondary: _grey, onSurfaceBlock: _fadeLightGreyColor),
    ],
    pageTransitionsTheme: PageTransitionsTheme(
      builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
        TargetPlatform.values,
        value: (dynamic _) => const CustomTransitionBuilder(),
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'sf',
    brightness: Brightness.dark,

    textTheme: AppTextTheme.darkTextTheme,
    colorScheme: AppColorScheme.darkColorScheme,
    extensions: <ThemeExtension<dynamic>>[
      const CustomColorsExtension(onSurfaceSecondary: _darkGrey, onSurfaceBlock: _fadeDarkGreyColor),
    ],
    pageTransitionsTheme: PageTransitionsTheme(
      builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
        TargetPlatform.values,
        value: (dynamic _) => const CustomTransitionBuilder(),
      ),
    ),
  );
}

class CustomTransitionBuilder extends PageTransitionsBuilder {
  const CustomTransitionBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(opacity: animation, child: child);
  }
}
