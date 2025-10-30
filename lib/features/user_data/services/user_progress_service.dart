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
    final result = await supabase
        .from('user_progress')
        .select()
        .eq('user_id', userId)
        .maybeSingle();

    if (result == null) {
      final currentMonth =
          '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}';

      final defaultProgress = {
        'user_id': userId,
        'month': currentMonth,
        'total_hassanat': 0,
        'surahs_read': [],
        'liked_ayahs': {},
        'daily_streak': 0,
        'best_streak': 0,
        'achievements_unlocked': <int>[],
        'weekly_hassanat': {},
      };

      final inserted = await supabase
          .from('user_progress')
          .insert(defaultProgress)
          .select()
          .maybeSingle();

      return UserProgress.fromJson(inserted!);
    }
    return UserProgress.fromJson(result);
  }
}
