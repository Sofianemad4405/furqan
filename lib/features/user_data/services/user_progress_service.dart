import 'package:furqan/features/user_data/models/user_progress.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserProgressService {
  final supabase = Supabase.instance.client;

  Future<void> updateUserProgress(
    String userId,
    Map<String, dynamic> updates,
  ) async {
    await supabase.from('user_progress').update(updates).eq('user_id', userId);
  }

  Future<UserProgress> getUserProgress(String userId) async {
    final res = await supabase
        .from('user_progress')
        .select()
        .eq('user_id', userId)
        .maybeSingle();

    if (res == null) {
      final defaultProgress = {
        'user_id': userId,
        'total_hassanat': 0,
        'surahs_read': 0,
        'minutes_of_reading_quraan': 0,
        'current_streak': 0,
        'longest_streak': 0,
        'daily_challenges_completed': 0,
        'duaas_recited': 0,
        'zikr_count': 0,
        'achievements_unlocked_ids': [],
        'today_challenges': [],
      };

      final inserted = await supabase
          .from('user_progress')
          .insert(defaultProgress)
          .select()
          .maybeSingle();

      return UserProgress.fromJson(inserted!);
    }
    return UserProgress.fromJson(res);
  }
}
