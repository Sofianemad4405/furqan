import 'dart:developer';

import 'package:furqan/features/stats/data/models/user_achievement.dart';
import 'package:furqan/features/user_data/controller/user_controller_abstract.dart';
import 'package:furqan/features/user_data/models/daily_challenge_model.dart';
import 'package:furqan/features/user_data/models/user_daily_challenge.dart';
import 'package:furqan/features/user_data/models/user_progress.dart';
import 'package:furqan/features/user_data/services/user_progress_service.dart';

class UserDataController implements UserControllerAbstract {
  final UserProgressService _userProgressService;
  UserDataController(this._userProgressService);

  @override
  Future<void> updateUserProgress(
    String userId,
    Map<String, dynamic> updates,
  ) async {
    try {
      log("updating");
      await _userProgressService.updateUserProgress(userId, updates);
    } on Exception catch (e) {
      log("updating failed $e");
    }
  }

  @override
  Future<UserProgress> getUserProgress(String userId) async {
    try {
      return _userProgressService.fetchUserProgress(userId);
    } on Exception catch (e) {
      throw Exception('Failed to get user progress: $e');
    }
  }

  @override
  Future<List<DailyChallengeModel>> getDailyChallenges() async {
    try {
      return await _userProgressService.fetchDailyChallenges();
    } catch (e) {
      throw Exception('Failed to get daily challenges: $e');
    }
  }

  @override
  Future<List<UserDailyChallenge>> getUserDailyChallengesProgress(
    String userId,
  ) async {
    try {
      return await _userProgressService.fetchUserDailyChallengesProgress(
        userId,
      );
    } on Exception catch (e) {
      throw Exception('Failed to get user daily challenges progress: $e');
    }
  }

  @override
  Future<List<UserAchievement>> getUserAchievements(String userId) async {
    try {
      return await _userProgressService.fetchUserAchievements(userId);
    } on Exception catch (e) {
      throw Exception('Failed to get user achievements: $e');
    }
  }
}
