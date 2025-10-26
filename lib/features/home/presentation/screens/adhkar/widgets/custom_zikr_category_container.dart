import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomZikrCategoryContainer extends StatelessWidget {
  const CustomZikrCategoryContainer({
    super.key,
    required this.gradient,
    required this.iconPath,
  });
  final List<Color> gradient;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 40,
      // width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: gradient,
          begin: AlignmentGeometry.topLeft,
          end: AlignmentGeometry.bottomRight,
        ),
      ),
      child: Center(child: SvgPicture.asset(iconPath, height: 24, width: 24)),
    );
  }
}
