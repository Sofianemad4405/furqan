import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends Cubit<ThemeMode> {
  static const String _themeKey = 'theme_mode';
  static const String _languageKey = 'language_code';

  ThemeMode _themeMode = ThemeMode.system;
  String _languageCode = 'en';
  bool _isArabicFont = false;

  ThemeMode get themeMode => _themeMode;
  String get languageCode => _languageCode;
  bool get isArabicFont => _isArabicFont;

  bool get isDarkMode {
    if (_themeMode == ThemeMode.system) {
      return WidgetsBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;
    }
    return _themeMode == ThemeMode.dark;
  }

  ThemeProvider(super.initialState) {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    // Load theme mode
    final themeIndex = prefs.getInt(_themeKey) ?? 0;
    _themeMode = ThemeMode.values[themeIndex];

    // Load language
    _languageCode = prefs.getString(_languageKey) ?? 'en';
    _isArabicFont = _languageCode == 'ar';

    emit(state);
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    _themeMode = themeMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, themeMode.index);
    emit(state);
  }

  Future<void> setLanguage(String languageCode) async {
    _languageCode = languageCode;
    _isArabicFont = languageCode == 'ar';
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, languageCode);
    emit(state);
  }

  void toggleTheme() {
    if (_themeMode == ThemeMode.light) {
      setThemeMode(ThemeMode.dark);
    } else if (_themeMode == ThemeMode.dark) {
      setThemeMode(ThemeMode.system);
    } else {
      setThemeMode(ThemeMode.light);
    }
  }

  String getThemeName() {
    switch (_themeMode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }

  IconData getThemeIcon() {
    switch (_themeMode) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.brightness_auto;
    }
  }
}
