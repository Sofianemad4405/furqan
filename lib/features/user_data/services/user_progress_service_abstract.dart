import 'package:furqan/features/stats/data/models/achievement.dart';
import 'package:furqan/features/stats/data/models/user_achievement.dart';
import 'package:furqan/features/user_data/models/daily_challenge_model.dart';
import 'package:furqan/features/user_data/models/user_daily_challenge.dart';
import 'package:furqan/features/user_data/models/user_progress.dart';

abstract class UserProgressServiceAbstract {
  Future<void> updateUserProgress(String userId, Map<String, dynamic> updates);
  Future<UserProgress> fetchUserProgress(String userId);

  Future<List<DailyChallengeModel>> fetchDailyChallenges();
  Future<List<UserDailyChallenge>> fetchUserDailyChallengesProgress(
    String userId,
  );

  Future<List<Achievement>> fetchAchievements();
  Future<List<UserAchievement>> fetchUserAchievements(String userId);
}
