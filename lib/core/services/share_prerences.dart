import 'package:shared_preferences/shared_preferences.dart';

class ThemeSharedPrerences {
  static const _themeKey = 'theme_mode';

  Future<void> setThemeMode(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, isDark);
  }

  Future<bool> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_themeKey) ?? false;
  }
}

class Image3DSharedPrerences {
  static const _is3Dkey = '3D_mode';

  Future<void> set3DMode(bool is3D) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool(_is3Dkey, is3D);
  }

  Future<bool> get3DMode() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool(_is3Dkey) ?? false;
  }
}
