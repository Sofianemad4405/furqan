import 'package:flutter/material.dart';
import 'package:furqan/core/themes/theme_system.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.isDarkMood,
    required this.child,
  });
  final bool isDarkMood;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: QuranAppTheme.adaptiveGlassDecoration(
        context,
        backgroundColor: isDarkMood
            ? QuranAppTheme.gray800
            : QuranAppTheme.gray50,
        borderColor: isDarkMood
            ? const Color(0xff21252A)
            : QuranAppTheme.gray400,
        borderRadius: 12,
      ),
      child: child,
    );
  }
}
