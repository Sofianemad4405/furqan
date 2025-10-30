import 'package:flutter/material.dart';
import 'package:furqan/features/home/presentation/widgets/custom_container.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

class Streak extends StatelessWidget {
  const Streak({
    super.key,
    required this.currentStreak,
    required this.challengesCompleted,
  });
  final int currentStreak;
  final int challengesCompleted;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CustomContainer(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 8,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4.0,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                              color: const Color(0xFFC8F0DC),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const SizedBox(
                              height: 24,
                              width: 24,
                              child: Center(
                                child: Icon(
                                  Iconsax.calendar,
                                  color: Color(0xFF25A479),
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                          const Gap(5),
                          Text(
                            "Current Streak",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "$currentStreak days",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Gap(20),
          Expanded(
            child: CustomContainer(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 8,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF4EFBA),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const SizedBox(
                              height: 24,
                              width: 24,
                              child: Center(
                                child: Icon(
                                  Iconsax.cup,
                                  color: Color(0xFFD09724),
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                          const Gap(5),
                          Text(
                            "Completed",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "$challengesCompleted challenges",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
