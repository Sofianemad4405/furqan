import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/core/themes/theme_system.dart';
import 'package:furqan/features/auth/presentation/auth_screen.dart';

class Furqan extends StatelessWidget {
  const Furqan({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: QuranAppTheme.lightTheme,
      // darkTheme: QuranAppTheme.darkTheme,
      // themeMode: state,
      home: AuthScreen(),
    );
  }
}
