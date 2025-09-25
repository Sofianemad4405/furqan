import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furqan/app/root_page.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/core/themes/theme_system.dart';

class Furqan extends StatelessWidget {
  const Furqan({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: QuranAppTheme.lightTheme,
          darkTheme: QuranAppTheme.darkTheme,
          themeMode: state,
          home: const RootPage(),
        );
      },
    );
  }
}
