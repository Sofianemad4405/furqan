import 'dart:developer';

import 'package:furqan/features/user_data/models/user_progress.dart';
import 'package:furqan/features/user_data/services/user_progress_service.dart';

class UserDataController {
  final UserProgressService _userProgressService;
  UserDataController(this._userProgressService);

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

  Future<UserProgress> getUserProgress(String userId) async {
    return _userProgressService.getUserProgress(userId);
  }
}
