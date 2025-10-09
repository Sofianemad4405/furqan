part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final UserProgress userProgress;

  const HomeLoaded({required this.userProgress});
}

final class HomeUpdated extends HomeState {
  final UserProgress userProgress;

  const HomeUpdated({required this.userProgress});
}

final class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});
}
