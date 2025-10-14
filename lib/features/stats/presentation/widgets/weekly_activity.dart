import 'package:flutter/material.dart';
import 'package:furqan/features/home/presentation/widgets/custom_container.dart';
import 'package:furqan/features/stats/data/models/weekly_progress.dart';

class WeeklyActivity extends StatelessWidget {
  const WeeklyActivity({
    super.key,
    required this.isDark,
    required this.maxHassanat,
    required this.weeklyProgress,
  });
  final bool isDark;
  final int maxHassanat;
  final List<WeeklyProgress> weeklyProgress;

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
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.trending_up,
                  size: 20,
                  color: isDark ? Colors.grey[200] : Colors.grey[800],
                ),
                const SizedBox(width: 8),
                Text(
                  'This Week',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.grey[200] : Colors.grey[800],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: weeklyProgress.map((day) {
                  final barHeight = (day.hasanat / maxHassanat * 80).clamp(
                    4.0,
                    80.0,
                  );
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: barHeight,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [Color(0xFF10B981), Color(0xFF34D399)],
                              ),
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(4),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            day.day,
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark
                                  ? Colors.grey[400]
                                  : Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            day.hasanat.toString(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? const Color(0xFF34D399)
                                  : const Color(0xFF059669),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
