import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../domain/repositories/settings_repository.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final SettingsRepository _settingsRepository;

  ThemeBloc({
    required SettingsRepository settingsRepository,
    required ThemeMode initialThemeMode,
  }) : _settingsRepository = settingsRepository,
       super(ThemeState(themeMode: initialThemeMode)) {
    on<ThemeChanged>(
      (event, emit) async {
        await _settingsRepository.saveThemeMode(event.themeMode);
        emit(ThemeState(themeMode: event.themeMode));
      },
    );
  }
}
