import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';
import 'package:furqan/core/themes/theme_system.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, required this.child, this.decoration});
  final Widget child;
  final Decoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          decoration ??
          QuranAppTheme.adaptiveGlassDecoration(
            context,
            backgroundColor: context.read<ThemeCubit>().isDarkMood()
                ? const Color(0XFF1D2737)
                : const Color.fromARGB(255, 255, 255, 255),
            borderColor: context.read<ThemeCubit>().isDarkMood()
                ? const Color(0xff21252A)
                : QuranAppTheme.gray400,
            borderRadius: 12,
          ),
      child: child,
    );
  }
}
