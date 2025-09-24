import 'package:flutter/material.dart';
import 'package:furqan/app/root_page.dart';
import 'package:furqan/core/themes/theme_system.dart';

class Furqan extends StatelessWidget {
  const Furqan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: QuranAppTheme.lightTheme,
      darkTheme: QuranAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const RootPage(),
    );
  }
}
