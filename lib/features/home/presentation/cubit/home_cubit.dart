import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:furqan/core/services/prefs.dart';
import 'package:furqan/features/user_data/controller/user_data_controller.dart';
import 'package:furqan/features/user_data/models/user_progress.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._userDataController, this.prefs)
    : userId = prefs.userId,
      super(HomeInitial());
  final UserDataController _userDataController;
  final Prefs prefs;
  final String? userId;

  void init() {
    loadUserData();
  }

  Future<void> loadUserData() async {
    emit(HomeLoading());
    try {
      final userData = await _userDataController.getUserProgress(userId!);
      emit(HomeLoaded(userProgress: userData));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  Future<UserProgress> getUserProgress() async {
    final userData = await _userDataController.getUserProgress(userId!);
    return userData;
  }

  Future<void> updateUserData(Map<String, dynamic> updates) async {
    emit(HomeLoading());
    try {
      await _userDataController.updateUserProgress(userId!, updates);
      final userData = await _userDataController.getUserProgress(userId!);
      emit(HomeLoaded(userProgress: userData));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }
}
