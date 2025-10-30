import 'package:flutter/material.dart';
import 'package:furqan/features/home/presentation/widgets/custom_container.dart';
import 'package:gap/gap.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.totalChallenges,
    required this.completedChallenges,
  });
  final int totalChallenges;
  final int completedChallenges;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                    const Gap(10),
                    Text(
                      "Daily Challenges",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
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
                  "$completedChallenges/$totalChallenges",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: const Color(0xFF009362),
                  ),
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
                    "${completedChallenges / totalChallenges * 100}%",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: const Color(0xFF009362),
                    ),
                  ),
                ],
              ),
              const Gap(5),
              LinearProgressIndicator(
                minHeight: 10,
                borderRadius: BorderRadius.circular(16),
                value: completedChallenges / totalChallenges,
                backgroundColor: const Color(0xFFC4C4C7),
                color: const Color(0xFF009362),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
