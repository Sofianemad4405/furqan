import 'dart:async';

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
    if (state is UserProgressLoaded) {
      final current = (state as UserProgressLoaded).userProgress;
      final surahKey = surahNo.toString();
      final likedAyahs = Map<String, List<int>>.from(current.likedAyahs);

      likedAyahs.putIfAbsent(surahKey, () => []);
      if (likedAyahs[surahKey]!.contains(ayahNumber)) {
        likedAyahs[surahKey]!.remove(ayahNumber);
      } else {
        likedAyahs[surahKey]!.add(ayahNumber);
      }

      final updatedProgress = current.copyWith(likedAyahs: likedAyahs);
      emit(UserProgressLoaded(userProgress: updatedProgress));
      updateUserData({'liked_ayahs': likedAyahs});
    }
  }
}
