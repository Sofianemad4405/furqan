import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainer extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;

  const ShimmerContainer({
    super.key,
    this.height = 20,
    this.width = double.infinity,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Shimmer.fromColors(
      baseColor: theme.scaffoldBackgroundColor.withValues(alpha: 0.3),
      highlightColor: theme.scaffoldBackgroundColor.withValues(alpha: 0.3),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
