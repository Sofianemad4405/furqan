import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furqan/app/root_page.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/core/themes/theme_system.dart';
import 'package:furqan/features/auth/data/models/user_data.dart';
import 'package:furqan/features/auth/presentation/screens/auth_screen.dart';

class Furqan extends StatelessWidget {
  const Furqan({super.key, required this.isLoggedIn});
  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: QuranAppTheme.lightTheme,
          darkTheme: QuranAppTheme.darkTheme,
          themeMode: state,
          // home: isLoggedIn ? const RootPage() : const AuthScreen(),
          home: const RootPage(),
        );
      },
    );
  }
}
