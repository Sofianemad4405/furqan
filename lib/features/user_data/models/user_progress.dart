import 'package:furqan/features/user_data/models/today_challenge.dart';

class UserProgress {
  String userId;
  int totalHassanat;
  int surahsRead;
  int minutesOfReadingQuraan;
  List<TodayChallenge> todayChallenges;
  int currentStreak;
  int longestStreak;
  int dailyChallengesCompleted;
  List<int> achievementsUnlockedIds;
  int duaasRecited;
  int zikrCount;
  List<int> surahsReadIds;
  int ayahsRead;

  UserProgress({
    required this.userId,
    required this.totalHassanat,
    required this.surahsRead,
    required this.minutesOfReadingQuraan,
    required this.todayChallenges,
    required this.currentStreak,
    required this.longestStreak,
    required this.dailyChallengesCompleted,
    required this.achievementsUnlockedIds,
    required this.duaasRecited,
    required this.zikrCount,
    required this.surahsReadIds,
    required this.ayahsRead,
  });
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'total_hassanat': totalHassanat,
      'surahs_read': surahsRead,
      'minutes_of_reading_quraan': minutesOfReadingQuraan,
      'current_streak': currentStreak,
      'longest_streak': longestStreak,
      'daily_challenges_completed': dailyChallengesCompleted,
      'duaas_recited': duaasRecited,
      'zikr_count': zikrCount,
      'achievements_unlocked_ids': achievementsUnlockedIds,
      'today_challenges': todayChallenges,
      'surahs_read_ids': surahsReadIds,
      'ayahs_read': ayahsRead,
    };
  }

  factory UserProgress.fromJson(Map<String, dynamic> json) {
    final todayChallengesData = json['today_challenges'];
    return UserProgress(
      ayahsRead: json['ayahs_read'] ?? 0,
      userId: json['user_id'] ?? '',
      totalHassanat: json['total_hassanat'] ?? 0,
      surahsRead: json['surahs_read'] ?? 0,
      minutesOfReadingQuraan: json['minutes_of_reading_quraan'] ?? 0,
      todayChallenges:
          todayChallengesData != null && todayChallengesData is List
          ? todayChallengesData.map((x) => TodayChallenge.fromJson(x)).toList()
          : _defaultTodayChallenges(),
      currentStreak: json['current_streak'] ?? 0,
      longestStreak: json['longest_streak'] ?? 0,
      dailyChallengesCompleted: json['daily_challenges_completed'] ?? 0,
      achievementsUnlockedIds: List<int>.from(
        json['achievements_unlocked_ids'] ?? [],
      ),
      duaasRecited: json['duaas_recited'] ?? 0,
      zikrCount: json['zikr_count'] ?? 0,
      surahsReadIds: List<int>.from(json['surahs_read_ids'] ?? []),
    );
  }

  static List<TodayChallenge> _defaultTodayChallenges() {
    return [
      TodayChallenge(
        id: 1,
        icon: "📖",
        title: "Read 5 Ayahs",
        description: "Recite at least 5 ayahs from the Quran today.",
        target: 5,
        finished: 0,
      ),
      TodayChallenge(
        id: 2,
        icon: "✨",
        title: "Dhikr Session",
        description: "Repeat your daily dhikr 100 times.",
        target: 100,
        finished: 0,
      ),
      TodayChallenge(
        id: 3,
        icon: "🤲",
        title: "Morning Duas",
        description:
            "Read 3 morning supplications to start your day with barakah.",
        target: 3,
        finished: 0,
      ),
    ];
  }

  ///copy constructor
  UserProgress copyWith({
    String? userId,
    int? totalHassanat,
    int? surahsRead,
    int? minutesOfReadingQuraan,
    List<TodayChallenge>? todayChallenges,
    int? currentStreak,
    int? longestStreak,
    int? dailyChallengesCompleted,
    List<int>? achievementsUnlockedIds,
    int? duaasRecited,
    int? zikrCount,
    List<int>? surahsReadIds,
    int? ayahsRead,
  }) {
    return UserProgress(
      ayahsRead: ayahsRead ?? this.ayahsRead,
      userId: userId ?? this.userId,
      totalHassanat: totalHassanat ?? this.totalHassanat,
      surahsRead: surahsRead ?? this.surahsRead,
      minutesOfReadingQuraan:
          minutesOfReadingQuraan ?? this.minutesOfReadingQuraan,
      todayChallenges: todayChallenges ?? this.todayChallenges,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      dailyChallengesCompleted:
          dailyChallengesCompleted ?? this.dailyChallengesCompleted,
      achievementsUnlockedIds:
          achievementsUnlockedIds ?? this.achievementsUnlockedIds,
      duaasRecited: duaasRecited ?? this.duaasRecited,
      zikrCount: zikrCount ?? this.zikrCount,
      surahsReadIds: surahsReadIds ?? this.surahsReadIds,
    );
  }
}
