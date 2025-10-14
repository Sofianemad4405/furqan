import 'package:flutter/material.dart';
import 'package:furqan/features/stats/data/models/user_stats.dart';
import 'package:furqan/features/stats/presentation/widgets/additional_stats_card.dart';
import 'package:gap/gap.dart';

class AdditionalStats extends StatelessWidget {
  const AdditionalStats({super.key, required this.isDark, required this.stats});
  final bool isDark;
  final UserStats stats;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AdditionalStatsCard(
            icon: '🤲',
            value: stats.duasRecited.toString(),
            label: 'Duas Recited',
            isDark: isDark,
          ),
        ),
        const Gap(16),
        Expanded(
          child: AdditionalStatsCard(
            icon: '✨',
            value: stats.dhikrCount.toString(),
            label: 'Dhikr Count',
            isDark: isDark,
          ),
        ),
      ],
    );
  }
}
