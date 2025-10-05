import 'package:flutter/material.dart';
import 'package:furqan/features/home/presentation/widgets/custom_container.dart';
import 'package:gap/gap.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Daily Challenges",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const Gap(5),
                    Text(
                      'Complete challenges to earn\nhasanat',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    Text(
                      "Today's\nProgress",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Gap(5),
                    Text(
                      "0/10",
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(color: const Color(0xFF009362)),
                    ),
                  ],
                ),
              ],
            ),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Daily Completion",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const Spacer(),
                      Text(
                        "0%",
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(color: const Color(0xFF009362)),
                      ),
                    ],
                  ),
                  const Gap(5),
                  LinearProgressIndicator(
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(16),
                    value: 0,
                    backgroundColor: const Color(0xFFC4C4C7),
                    color: const Color(0xFF009362),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
