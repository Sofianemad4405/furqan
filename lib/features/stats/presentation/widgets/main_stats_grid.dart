import 'package:flutter/material.dart';
import 'package:furqan/features/stats/data/utils/helpers.dart';
import 'package:furqan/features/stats/presentation/widgets/stats_card.dart';
import 'package:furqan/features/user_data/models/user_progress.dart';

class MainStatsGrid extends StatelessWidget {
  const MainStatsGrid({
    super.key,
    required this.isDark,
    required this.userProgress,
  });
  final bool isDark;
  final UserProgress userProgress;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: (height / width) * .8,
      children: [
        StatsCard(
          icon: '🌙',
          value: userProgress.totalHassanat.toString(),
          label: 'Total Hasanat',
          gradientColors: isDark
              ? [const Color(0xFF78350F), const Color(0xFF9A3412)]
              : [const Color(0xFFFEF3C7), const Color(0xFFFED7AA)],
          textColor: isDark ? const Color(0xFFFCD34D) : const Color(0xFFB45309),
          labelColor: isDark
              ? const Color(0xFFFBBF24)
              : const Color(0xFFD97706),
          borderColor: isDark
              ? const Color(0xFFB45309)
              : const Color(0xFFFDE68A),
          isDark: isDark,
        ),
        StatsCard(
          icon: '⏰',
          value: formatTime(userProgress.readingMinutes),
          label: 'Total Time',
          gradientColors: isDark
              ? [const Color(0xFF1E3A8A), const Color(0xFF3730A3)]
              : [const Color(0xFFDBEAFE), const Color(0xFFC7D2FE)],
          textColor: isDark ? const Color(0xFF93C5FD) : const Color(0xFF1D4ED8),
          labelColor: isDark
              ? const Color(0xFF60A5FA)
              : const Color(0xFF2563EB),
          borderColor: isDark
              ? const Color(0xFF1E40AF)
              : const Color(0xFFBFDBFE),
          isDark: isDark,
        ),
        StatsCard(
          icon: '📖',
          value: '${userProgress.surahsRead}/114',
          label: 'Surahs',
          gradientColors: isDark
              ? [const Color(0xFF064E3B), const Color(0xFF115E59)]
              : [const Color(0xFFD1FAE5), const Color(0xFFCCFBF1)],
          textColor: isDark ? const Color(0xFF6EE7B7) : const Color(0xFF047857),
          labelColor: isDark
              ? const Color(0xFF34D399)
              : const Color(0xFF059669),
          borderColor: isDark
              ? const Color(0xFF047857)
              : const Color(0xFFA7F3D0),
          isDark: isDark,
        ),
        StatsCard(
          icon: '🔥',
          value: userProgress.currentStreak.toString(),
          label: 'Day Streak',
          gradientColors: isDark
              ? [const Color(0xFF9A3412), const Color(0xFF991B1B)]
              : [const Color(0xFFFED7AA), const Color(0xFFFECDD3)],
          textColor: isDark ? const Color(0xFFFB923C) : const Color(0xFFC2410C),
          labelColor: isDark
              ? const Color(0xFFF97316)
              : const Color(0xFFEA580C),
          borderColor: isDark
              ? const Color(0xFFC2410C)
              : const Color(0xFFFED7AA),
          isDark: isDark,
        ),
      ],
    );
  }
}
