import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furqan/features/home/presentation/widgets/custom_container.dart';
import 'package:furqan/features/stats/presentation/widgets/progress_row.dart';
import 'package:furqan/features/user_data/models/user_progress.dart';

class QuranProgress extends StatelessWidget {
  const QuranProgress({
    super.key,
    required this.isDark,
    required this.userProgress,
  });
  final bool isDark;
  final UserProgress userProgress;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(16),
      //   border: Border.all(
      //     color: isDark
      //         ? Colors.white.withOpacity(0.1)
      //         : Colors.black.withOpacity(0.1),
      //   ),
      //   // boxShadow: [
      //   //   BoxShadow(
      //   //     color: Colors.black.withOpacity(0.1),
      //   //     blurRadius: 10,
      //   //     offset: const Offset(0, 4),
      //   //   ),
      //   // ],
      // ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  "assets/svgs/bookopen-icon (2).svg",
                  colorFilter: ColorFilter.mode(
                    isDark ? Colors.white : Colors.black,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Quran Completion',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.grey[200] : Colors.grey[800],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ProgressRow(
              label: 'Surahs Completed',
              value: '${userProgress.surahsRead}/114',
              progress: userProgress.surahsRead / 114,
              isDark: isDark,
            ),
            const SizedBox(height: 16),
            ProgressRow(
              label: 'Daily Challenges',
              value: userProgress.todayChallenges.entries.length.toString(),
              progress:
                  userProgress.todayChallenges.values.fold(0, (a, b) => a + b) /
                  100,
              isDark: isDark,
            ),
          ],
        ),
      ),
    );
  }
}
