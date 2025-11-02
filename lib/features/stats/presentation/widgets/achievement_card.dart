import 'package:flutter/material.dart';
import 'package:furqan/features/home/presentation/widgets/custom_container.dart';
import 'package:furqan/features/stats/data/models/achievement.dart';
import 'package:furqan/features/stats/data/models/user_achievement.dart';
import 'package:iconsax/iconsax.dart';

class AchievementCard extends StatelessWidget {
  const AchievementCard({
    super.key,
    required this.achievement,
    required this.isDark,
    required this.userAchievement,
  });
  final Achievement achievement;
  final UserAchievement userAchievement;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      borderColor: !userAchievement.unlocked
          ? (isDark ? Colors.grey[700]! : Colors.grey[200]!)
          : (isDark ? const Color(0xFF047857) : const Color(0xFFA7F3D0)),
      decoration: userAchievement.unlocked
          ? BoxDecoration(
              color: userAchievement.unlocked
                  ? (isDark
                        ? const Color(0xFF064E3B).withValues(alpha: 0.3)
                        : const Color(0xFFD1FAE5))
                  : (isDark ? Colors.white24 : Colors.grey[50]),
              // : null,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: userAchievement.unlocked
                    ? (isDark
                          ? const Color(0xFF047857)
                          : const Color(0xFFA7F3D0))
                    : (isDark ? Colors.grey[700]! : Colors.grey[200]!),
              ),
            )
          : null,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  achievement.icon,
                  style: TextStyle(
                    fontSize: 18,
                    color: userAchievement.unlocked ? null : Colors.grey,
                  ),
                ),
                const Spacer(),
                if (userAchievement.unlocked)
                  const Icon(Iconsax.tick_circle, color: Color(0xFF047857)),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              achievement.title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.grey[200] : Colors.grey[800],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              achievement.description,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
