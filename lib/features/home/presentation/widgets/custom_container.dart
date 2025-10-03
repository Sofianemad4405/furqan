import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/core/themes/theme_system.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: QuranAppTheme.adaptiveGlassDecoration(
        context,
        backgroundColor: context.read<ThemeCubit>().isDarkMood()
            ? QuranAppTheme.gray800
            : QuranAppTheme.gray50,
        borderColor: context.read<ThemeCubit>().isDarkMood()
            ? const Color(0xff21252A)
            : QuranAppTheme.gray400,
        borderRadius: 12,
      ),
      child: child,
    );
  }
}
