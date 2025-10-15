import 'package:flutter/material.dart';
import 'package:furqan/core/widgets/shimmers/shimmer_container.dart';

class HomeStatsShimmer extends StatelessWidget {
  const HomeStatsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: ShimmerContainer(height: 120, borderRadius: 20)),
        SizedBox(width: 20),
        Expanded(child: ShimmerContainer(height: 120, borderRadius: 20)),
        SizedBox(width: 20),
        Expanded(child: ShimmerContainer(height: 120, borderRadius: 20)),
      ],
    );
  }
}
