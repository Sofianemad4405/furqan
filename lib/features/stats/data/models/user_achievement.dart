class UserAchievement {
  final String id;
  final String userId;
  final String achievementId;
  final bool unlocked;
  final DateTime unlockedAt;

  UserAchievement({
    required this.id,
    required this.userId,
    required this.achievementId,
    required this.unlocked,
    required this.unlockedAt,
  });
  factory UserAchievement.fromJson(Map<String, dynamic> json) {
    return UserAchievement(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      achievementId: json['achievement_id'] as String,
      unlocked: json['unlocked'] as bool,
      unlockedAt: DateTime.parse(json['unlocked_at']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'achievement_id': achievementId,
      'unlocked': unlocked,
      'unlocked_at': unlockedAt.toIso8601String(),
    };
  }
}
