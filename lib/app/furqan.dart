import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furqan/app/root_page.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/core/themes/theme_system.dart';
import 'package:furqan/features/auth/data/models/user_data.dart';
import 'package:furqan/features/auth/presentation/screens/auth_screen.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class Furqan extends StatefulWidget {
  const Furqan({super.key, required this.isLoggedIn});
  final bool isLoggedIn;

  @override
  State<Furqan> createState() => _FurqanState();
}

class _FurqanState extends State<Furqan> {
  @override
  void initState() {
    super.initState();
    context.read<ThemeCubit>().init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: QuranAppTheme.lightTheme,
          darkTheme: QuranAppTheme.darkTheme,
          themeMode: state,
          home: widget.isLoggedIn
              ? const RootPage()
              : AuthScreen(onAuthComplete: (UserData p1) {}),
        );
      },
    );
  }
}
