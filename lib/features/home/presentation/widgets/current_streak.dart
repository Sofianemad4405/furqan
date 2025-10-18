import 'package:flutter/material.dart';
import 'package:furqan/features/user_data/models/user_progress.dart';
import 'package:gap/gap.dart';

class CurrentStreak extends StatelessWidget {
  const CurrentStreak({super.key, required this.userProgress});
  final UserProgress userProgress;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        gradient: LinearGradient(
          colors: [Color(0xFFF5830C), Color(0xFFF56261)],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Current Streak",
                  style: Theme.of(
                    context,
                  ).textTheme.headlineMedium?.copyWith(color: Colors.white),
                ),
                const Gap(3),
                Text(
                  "Keep up the great work!",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                ),
                const Spacer(),
                Text(
                  "Best: ${userProgress.longestStreak} days",
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.white),
                ),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                const Text(
                  "🔥",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                const Spacer(),
                Text(
                  "${userProgress.currentStreak}\ndays",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
