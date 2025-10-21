part of 'prayer_times_cubit.dart';

sealed class PrayerTimesState extends Equatable {
  const PrayerTimesState();

  @override
  List<Object> get props => [];
}

final class PrayerTimesInitial extends PrayerTimesState {}

final class PrayerTimesLoading extends PrayerTimesState {}

final class PrayerTimesLoaded extends PrayerTimesState {
  final PrayerResponseEntity prayerResponseEntity;

  const PrayerTimesLoaded({required this.prayerResponseEntity});
}

final class PrayerTimesError extends PrayerTimesState {
  final String error;

  const PrayerTimesError({required this.error});
}
