import 'package:flutter/material.dart';
import 'package:furqan/app/root_page.dart';
import 'package:furqan/core/themes/theme_modes.dart';

class Furqan extends StatelessWidget {
  const Furqan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.lightTheme,
      home: const RootPage(),
    );
  }
}
