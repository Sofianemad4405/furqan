import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:furqan/core/services/prefs.dart';
import 'package:furqan/features/user_data/controller/user_data_controller.dart';
import 'package:furqan/features/user_data/models/user_progress.dart';

part 'user_progress_state.dart';

class UserProgressCubit extends Cubit<UserProgresState> {
  UserProgressCubit(this._userDataController, this.prefs)
    : userId = prefs.userId,
      super(UserProgressInitial());
  final UserDataController _userDataController;
  final Prefs prefs;
  final String? userId;

  void init() {
    loadUserData();
  }

  Future<void> loadUserData() async {
    emit(UserProgressLoading());
    try {
      final userData = await _userDataController.getUserProgress(userId!);
      emit(UserProgressLoaded(userProgress: userData));
    } catch (e) {
      emit(UserProgressError(message: e.toString()));
    }
  }

  Future<UserProgress> getUserProgress() async {
    final userData = await _userDataController.getUserProgress(userId!);
    return userData;
  }

  Future<void> updateUserData(Map<String, dynamic> updates) async {
    // emit(UserProgressLoading());
    try {
      await _userDataController.updateUserProgress(userId!, updates);
      final userData = await _userDataController.getUserProgress(userId!);
      emit(UserProgressLoaded(userProgress: userData));
    } catch (e) {
      emit(UserProgressError(message: e.toString()));
    }
  }

  void toggleAyahLike(int surahNo, int ayahNumber) {
    if (state is! UserProgressLoaded) return;

    final currentState = state as UserProgressLoaded;
    final current = currentState.userProgress;

    // انسخ الماب والقوائم نسخ عميق (deep copy)
    final updatedLikes = <String, List<int>>{};
    current.likedAyahs.forEach((key, value) {
      updatedLikes[key] = List<int>.from(value);
    });

    final surahKey = surahNo.toString();
    final ayahs = updatedLikes[surahKey] ?? [];

    if (ayahs.contains(ayahNumber)) {
      ayahs.remove(ayahNumber);
    } else {
      ayahs.add(ayahNumber);
    }

    updatedLikes[surahKey] = List<int>.from(ayahs);

    final updatedProgress = current.copyWith(likedAyahs: updatedLikes);

    emit(UserProgressLoaded(userProgress: updatedProgress));

    updateUserData({'liked_ayahs': updatedLikes});
  }
}
