import 'package:furqan/features/stats/data/models/achievement.dart';
import 'package:furqan/features/stats/data/models/user_achievement.dart';
import 'package:furqan/features/user_data/models/daily_challenge_model.dart';
import 'package:furqan/features/user_data/models/user_daily_challenge.dart';
import 'package:furqan/features/user_data/models/user_progress.dart';
import 'package:furqan/features/user_data/services/user_progress_service_abstract.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserProgressService implements UserProgressServiceAbstract {
  final supabase = Supabase.instance.client;

  @override
  Future<void> updateUserProgress(
    String userId,
    Map<String, dynamic> updates,
  ) async {
    await supabase.from('user_progress').update(updates).eq('user_id', userId);
  }

  @override
  Future<UserProgress> fetchUserProgress(String userId) async {
    final result = await supabase
        .from('user_progress')
        .select()
        .eq('user_id', userId)
        .maybeSingle();

    if (result == null) {
      // final currentMonth =
      //     '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}';

      final defaultProgress = UserProgress(userId: userId).toJson();

      final inserted = await supabase
          .from('user_progress')
          .insert(defaultProgress)
          .select()
          .maybeSingle();

      return UserProgress.fromJson(inserted!);
    }
    return UserProgress.fromJson(result);
  }

  @override
  Future<List<UserDailyChallenge>> fetchUserDailyChallengesProgress(
    String userId,
  ) async {
    final result = await supabase
        .from('user_daily_challenges')
        .select()
        .eq('user_id', userId);
    return result.map((e) => UserDailyChallenge.fromJson(e)).toList();
  }

  @override
  Future<List<DailyChallengeModel>> fetchDailyChallenges() async {
    final result = await supabase.from('daily_challenges').select();
    return result.map((e) => DailyChallengeModel.fromJson(e)).toList();
  }

  @override
  Future<List<Achievement>> fetchAchievements() async {
    final result = await supabase.from('achievements').select();
    return result.map((e) => Achievement.fromJson(e)).toList();
  }

  @override
  Future<List<UserAchievement>> fetchUserAchievements(String userId) async {
    final result = await supabase
        .from('user_achievements')
        .select()
        .eq('user_id', userId);
    return result.map((e) => UserAchievement.fromJson(e)).toList();
  }
}
