import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:furqan/core/services/prefs.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(this.prefs) : super(ThemeMode.light);
  final Prefs prefs;

  void init() {
    final themeMode = prefs.themeMode;
    emit(themeMode == "dark" ? ThemeMode.dark : ThemeMode.light);
  }

  // String language = 'en';
  void toggleTheme() {
    emit(state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
    prefs.saveThemeMode(state == ThemeMode.dark ? "dark" : "light");
  }

  bool isDarkMood() {
    return state == ThemeMode.dark;
  }

  IconData getThemeIcon() {
    return state == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode;
  }

  // void setLanguage(String languageCode) {
  //   emit(languageCode);
  // }
}
