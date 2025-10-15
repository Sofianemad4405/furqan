import 'package:flutter/material.dart';
import 'package:furqan/core/widgets/shimmers/shimmer_container.dart';

class MainChallengesGridShimmer extends StatelessWidget {
  const MainChallengesGridShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320, // (2 rows * 150 item height) + 20 spacing
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 1.5,
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return const ShimmerContainer(height: 150);
        },
      ),
    );
  }
}
