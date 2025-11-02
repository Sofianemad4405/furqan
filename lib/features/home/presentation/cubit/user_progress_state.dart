part of 'user_progress_cubit.dart';

sealed class UserProgresState extends Equatable {
  const UserProgresState();

  @override
  List<Object> get props => [];
}

final class UserProgressInitial extends UserProgresState {}

final class UserProgressLoading extends UserProgresState {}

final class UserProgressLoaded extends UserProgresState {
  final UserProgress userProgress;
  final List<DailyChallengeModel> todayChallenges;
  final List<UserDailyChallenge> userDailyChallenges;

  const UserProgressLoaded({
    required this.userProgress,
    required this.todayChallenges,
    required this.userDailyChallenges,
  });
}

final class UserProgressUpdated extends UserProgresState {
  final UserProgress userProgress;

  const UserProgressUpdated({required this.userProgress});
}

final class UserProgressError extends UserProgresState {
  final String message;

  const UserProgressError({required this.message});
}
