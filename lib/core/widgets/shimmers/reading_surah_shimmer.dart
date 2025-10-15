import 'package:flutter/material.dart';
import 'package:furqan/core/widgets/shimmers/shimmer_container.dart';
import 'package:gap/gap.dart';

class ReadingSurahShimmer extends StatelessWidget {
  const ReadingSurahShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: ShimmerContainer(height: 90)),
                Gap(10),
                Expanded(child: ShimmerContainer(height: 90)),
                Gap(10),
                Expanded(child: ShimmerContainer(height: 90)),
              ],
            ),
          ),
          Gap(50),

          ShimmerContainer(height: 200, borderRadius: 16),
          Gap(20),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     ShimmerContainer(height: 40, borderRadius: 8),
          //     ShimmerContainer(height: 20),
          //     ShimmerContainer(height: 40, borderRadius: 8),
          //   ],
          // ),
          Gap(200),
        ],
      ),
    );
  }
}
