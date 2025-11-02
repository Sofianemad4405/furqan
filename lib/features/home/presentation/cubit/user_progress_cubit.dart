import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:furqan/core/services/prefs.dart';
import 'package:furqan/features/user_data/controller/user_data_controller.dart';
import 'package:furqan/features/user_data/models/daily_challenge_model.dart';
import 'package:furqan/features/user_data/models/user_daily_challenge.dart';
import 'package:furqan/features/user_data/models/user_progress.dart';

part 'user_progress_state.dart';

class UserProgressCubit extends Cubit<UserProgresState> {
  UserProgressCubit(this._userDataController, this.prefs)
    : userId = prefs.userId,
      super(UserProgressInitial()) {
    init();
  }

  final UserDataController _userDataController;
  final Prefs prefs;
  final String? userId;
  Timer? _debounceTimer;
  bool _isLoading = false;

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }

  void init() {
    if (userId == null) {
      emit(const UserProgressError(message: 'User ID is not available'));
      return;
    }
    loadUserProgress();
  }

  Future<UserProgress> getUserProgress() async {
    if (userId == null) {
      throw Exception('User ID is not available');
    }
    return await _userDataController.getUserProgress(userId!);
  }

  Future<void> loadUserProgress() async {
    if (_isLoading) return;
    _isLoading = true;
    emit(UserProgressLoading());

    try {
      final results = await Future.wait([
        _userDataController.getUserProgress(userId!),
        _userDataController.getDailyChallenges(),
        _userDataController.getUserDailyChallengesProgress(userId!),
      ]);

      final userProgress = results[0] as UserProgress;
      final todayChallenges = (results[1] as List)
          .map((e) => DailyChallengeModel.fromJson(e as Map<String, dynamic>))
          .toList();
      final userDailyChallengesProgress = (results[2] as List)
          .map((e) => UserDailyChallenge.fromJson(e as Map<String, dynamic>))
          .toList();

      emit(
        UserProgressLoaded(
          userProgress: userProgress,
          todayChallenges: todayChallenges,
          userDailyChallenges: userDailyChallengesProgress,
        ),
      );
    } catch (e, stack) {
      log('Error in loadUserProgress', error: e, stackTrace: stack);
      emit(UserProgressError(message: 'Failed to load user progress: $e'));
    } finally {
      _isLoading = false;
    }
  }

  Future<void> updateUserData(Map<String, dynamic> updates) async {
    if (userId == null) return;

    // Cancel any pending update
    _debounceTimer?.cancel();

    // Start a new timer - will wait 500ms before executing
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      // This code only runs after 500ms of no new updates
      try {
        if (state is! UserProgressLoaded) return;
        final currentState = state as UserProgressLoaded;

        // Optimistically update the state
        final updatedUser = _getUpdatedUserProgress(
          currentState.userProgress,
          updates,
        );
        emit(
          UserProgressLoaded(
            userProgress: updatedUser,
            todayChallenges: currentState.todayChallenges,
            userDailyChallenges: currentState.userDailyChallenges,
          ),
        );

        // Perform the actual update
        await _userDataController.updateUserProgress(userId!, updates);
      } catch (e, stack) {
        log('Error updating user data', error: e, stackTrace: stack);
        emit(UserProgressError(message: 'Failed to update: $e'));
        // Reload data on error to ensure consistency
        loadUserProgress();
      }
    });
  }

  UserProgress _getUpdatedUserProgress(
    UserProgress current,
    Map<String, dynamic> updates,
  ) {
    return current.copyWith(
      totalHassanat: updates['total_hassanat'] ?? current.totalHassanat,
      surahsRead: updates['surahs_read'] ?? current.surahsRead,
      readingMinutes: updates['reading_minutes'] ?? current.readingMinutes,
      duasRecited: updates['duas_recited'] ?? current.duasRecited,
      zikrCount: updates['zikr_count'] ?? current.zikrCount,
      ayahsRead: updates['ayahs_read'] ?? current.ayahsRead,
      currentStreak: updates['current_streak'] ?? current.currentStreak,
      bestStreak: updates['best_streak'] ?? current.bestStreak,
      todayChallenges: updates['today_challenges'] ?? current.todayChallenges,
      surahsReadIds: updates['surahs_read_ids'] ?? current.surahsReadIds,
      likedAyahs: updates['liked_ayahs'] ?? current.likedAyahs,
      weeklyHassanat: updates['weekly_hassanat'] ?? current.weeklyHassanat,
      updatedAt: DateTime.now(),
    );
  }

  Future<void> toggleAyahLike(int surahNo, int ayahNumber) async {
    if (state is! UserProgressLoaded) return;

    try {
      final current = (state as UserProgressLoaded).userProgress;
      final surahKey = surahNo.toString();

      final likedAyahs = Map<String, List<int>>.from(current.likedAyahs);
      likedAyahs.putIfAbsent(surahKey, () => []);

      final ayahList = likedAyahs[surahKey]!;
      if (ayahList.contains(ayahNumber)) {
        ayahList.remove(ayahNumber);
      } else {
        ayahList.add(ayahNumber);
      }

      await updateUserData({'liked_ayahs': likedAyahs});
    } catch (e, stack) {
      log('Error toggling ayah like', error: e, stackTrace: stack);
      emit(UserProgressError(message: 'Failed to toggle ayah like: $e'));
    }
  }

  Future<List<DailyChallengeModel>> getDailyChallenges() async {
    return await _userDataController.getDailyChallenges();
  }

  Future<List<UserDailyChallenge>> getUserDailyChallengesProgress() async {
    return await _userDataController.getUserDailyChallengesProgress(userId!);
  }
}
