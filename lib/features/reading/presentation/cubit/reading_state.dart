part of 'reading_cubit.dart';

sealed class ReadingState extends Equatable {
  const ReadingState();

  @override
  List<Object> get props => [];
}

/// Displaying Surahs and Choosing Surah
final class ReadingInitial extends ReadingState {}

final class SurahsLoading extends ReadingState {}

final class ChoosingSurah extends ReadingState {
  final List<SurahBaseEntity> surahs;

  const ChoosingSurah({required this.surahs});
}

final class ErrorChoosingSurah extends ReadingState {
  final String message;

  const ErrorChoosingSurah({required this.message});
}

final class ChoosingMode extends ReadingState {
  final int surahNo;
  final String surahName;

  const ChoosingMode({required this.surahNo, required this.surahName});
}

final class SurahLoading extends ReadingState {}

final class SurahLoaded extends ReadingState {
  final SurahEntity surah;

  const SurahLoaded({required this.surah});
}

final class ErrorSurah extends ReadingState {
  final String message;

  const ErrorSurah({required this.message});
}
