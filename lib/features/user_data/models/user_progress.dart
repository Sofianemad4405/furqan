class UserProgress {
  String userId;
  int totalHassanat;
  int surahsRead;
  int readingMinutes;
  int duasRecited;
  int zikrCount;
  int ayahsRead;
  int currentStreak;
  int bestStreak;
  List<int> todayChallenges;
  List<int> achievementsUnlocked;
  List<int> surahsReadIds;
  Map<String, dynamic> likedAyahs;
  Map<String, int> weeklyHassanat;
  DateTime createdAt;
  DateTime updatedAt;

  UserProgress({
    required this.userId,
    this.totalHassanat = 0,
    this.surahsRead = 0,
    this.readingMinutes = 0,
    this.likedAyahs = const {},
    this.todayChallenges = const [],
    this.currentStreak = 0,
    this.bestStreak = 0,
    this.achievementsUnlocked = const [],
    this.weeklyHassanat = const {},
    DateTime? createdAt,
    DateTime? updatedAt,
    this.duasRecited = 0,
    this.zikrCount = 0,
    this.surahsReadIds = const [],
    this.ayahsRead = 0,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory UserProgress.fromJson(Map<String, dynamic> json) {
    return UserProgress(
      userId: json['user_id'] as String,
      totalHassanat: json['total_hassanat'] as int,
      surahsRead: json['surahs_read'] as int,
      readingMinutes: json['reading_minutes'] as int,
      likedAyahs: Map<String, dynamic>.from(json['liked_ayahs'] ?? {}),
      todayChallenges: List<int>.from(json['today_challenges'] ?? []),
      currentStreak: json['current_streak'] as int,
      bestStreak: json['best_streak'] as int,
      achievementsUnlocked: List<int>.from(json['achievements_unlocked'] ?? []),
      weeklyHassanat: Map<String, int>.from(json['weekly_hassanat'] ?? {}),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      duasRecited: json['duas_recited'] as int,
      zikrCount: json['zikr_count'] as int,
      surahsReadIds: List<int>.from(json['surahs_read_ids'] ?? []),
      ayahsRead: json['ayahs_read'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'total_hassanat': totalHassanat,
      'surahs_read': surahsRead,
      'reading_minutes': readingMinutes,
      'liked_ayahs': likedAyahs,
      'today_challenges': todayChallenges,
      'current_streak': currentStreak,
      'best_streak': bestStreak,
      'achievements_unlocked': achievementsUnlocked,
      'weekly_hassanat': weeklyHassanat,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'duas_recited': duasRecited,
      'zikr_count': zikrCount,
      'surahs_read_ids': surahsReadIds,
      'ayahs_read': ayahsRead,
    };
  }
}
