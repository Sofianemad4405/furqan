import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.child,
    this.decoration,
    this.borderColor,
    // this.padding,
  });
  final Widget child;
  final Decoration? decoration;
  final Color? borderColor;
  // final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().isDarkMood();
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          // padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDark
                ? const Color(0x33000000) // dark glass
                : const Color(0xB3FFFFFF), // light glass
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? const Color(0x1AFFFFFF) : const Color(0x33FFFFFF),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.3 : 0.1),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
