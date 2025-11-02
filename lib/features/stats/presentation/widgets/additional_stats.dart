import 'package:flutter/material.dart';
import 'package:furqan/features/stats/presentation/widgets/additional_stats_card.dart';
import 'package:furqan/features/user_data/models/user_progress.dart';
import 'package:gap/gap.dart';

class AdditionalStats extends StatelessWidget {
  const AdditionalStats({
    super.key,
    required this.isDark,
    required this.userProgress,
  });
  final bool isDark;
  final UserProgress userProgress;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AdditionalStatsCard(
            icon: '🤲',
            value: userProgress.duasRecited.toString(),
            label: 'Duas Recited',
            isDark: isDark,
          ),
        ),
        const Gap(16),
        Expanded(
          child: AdditionalStatsCard(
            icon: '✨',
            value: userProgress.zikrCount.toString(),
            label: 'Dhikr Count',
            isDark: isDark,
          ),
        ),
      ],
    );
  }
}
