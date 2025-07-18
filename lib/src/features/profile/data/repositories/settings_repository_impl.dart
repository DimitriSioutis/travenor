import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travenor/src/features/profile/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  static const String _themeKey = 'app_theme';

  @override
  Future<void> saveThemeMode(ThemeMode themeMode) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt(_themeKey, themeMode.index);
  }

  @override
  Future<ThemeMode> loadThemeMode() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final themeIndex = sharedPreferences.getInt(_themeKey);

    if (themeIndex == null) {
      return ThemeMode.system;
    }

    return ThemeMode.values[themeIndex];
  }
}
