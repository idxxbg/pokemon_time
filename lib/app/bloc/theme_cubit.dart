import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/services/share_prerences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(this._preferences) : super(_lightMode) {
    loadThemeMode();
  }
  final ThemeSharePrerences _preferences;
  static const _lightMode = ThemeMode.light;
  static const _darkMode = ThemeMode.dark;

  Future<void> loadThemeMode() async {
    bool isDark = await _preferences.getThemeMode();
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> changeThemeMode() async {
    final isDark = state == ThemeMode.dark;
    emit(isDark ? _lightMode : _darkMode);
    await _preferences.setThemeMode(!isDark);
  }
}
