import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  // String language = 'en';
  void toggleTheme() {
    if (state == ThemeMode.light) {
      emit(ThemeMode.dark);
    } else {
      emit(ThemeMode.light);
    }
  }

  void setTheme(ThemeMode themeMode) {
    emit(themeMode);
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
