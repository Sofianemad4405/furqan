import 'package:flutter/material.dart';
import 'package:furqan/features/settings/presentation/widgets/profile_badge.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.userPhoto,
    required this.navigateToProfileEdit,
    required this.userName,
    required this.currentStreak,
    required this.totalHasanat,
  });
  final String? userPhoto;
  final Function()? navigateToProfileEdit;
  final String? userName;
  final int currentStreak;
  final int totalHasanat;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF10B981), Color(0xFF0D9488)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: navigateToProfileEdit,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 3,
                    ),
                  ),
                  child: userPhoto != null
                      ? CircleAvatar(backgroundImage: NetworkImage(userPhoto!))
                      : const Center(
                          child: Text(
                            'U',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (userName != null)
                        Text(
                          userName!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      const SizedBox(height: 4),
                      const Text(
                        'Reading since January 2024',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFFD1FAE5),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: [
                          ProfileBadge(text: '$currentStreak Day Streak 🔥'),
                          ProfileBadge(text: '$totalHasanat Hasanat ✨'),
                        ],
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.white, size: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
