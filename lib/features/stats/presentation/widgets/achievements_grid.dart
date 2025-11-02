import 'package:flutter/material.dart';
import 'package:furqan/features/home/presentation/widgets/custom_container.dart';
import 'package:furqan/features/stats/data/models/achievement.dart';
import 'package:furqan/features/stats/data/models/user_achievement.dart';
import 'package:furqan/features/stats/presentation/widgets/achievement_card.dart';

class AchievementsGrid extends StatelessWidget {
  const AchievementsGrid({
    super.key,
    required this.isDark,
    required this.achievements,
    required this.userAchievements,
  });
  final bool isDark;
  final List<Achievement> achievements;
  final List<UserAchievement> userAchievements;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return CustomContainer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.emoji_events, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Achievements',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.grey[200] : Colors.grey[800],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: (height / width) * .35,
              ),
              itemCount: achievements.length,
              itemBuilder: (context, index) {
                final achievement = achievements[index];
                return AchievementCard(
                  achievement: achievement,
                  isDark: isDark,
                  userAchievement: userAchievements[index],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
