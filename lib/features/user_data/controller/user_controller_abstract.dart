import 'package:furqan/features/stats/data/models/user_achievement.dart';
import 'package:furqan/features/user_data/models/daily_challenge_model.dart';
import 'package:furqan/features/user_data/models/user_daily_challenge.dart';
import 'package:furqan/features/user_data/models/user_progress.dart';

abstract class UserControllerAbstract {
  Future<void> updateUserProgress(String userId, Map<String, dynamic> updates);
  Future<UserProgress> getUserProgress(String userId);
  Future<List<UserAchievement>> getUserAchievements(String userId);
  Future<List<DailyChallengeModel>> getDailyChallenges();
  Future<List<UserDailyChallenge>> getUserDailyChallengesProgress(
    String userId,
  );
}
