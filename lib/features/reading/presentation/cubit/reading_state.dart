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

////choosing mode

final class ChoosingMode extends ReadingState {
  final int surahNo;
  final String surahName;

  const ChoosingMode({required this.surahNo, required this.surahName});
}

////listening mode
final class SurahLoadingInListeningMode extends ReadingState {}

final class SurahLoadedInListeningMode extends ReadingState {
  final SurahEntity surah;

  const SurahLoadedInListeningMode({required this.surah});
}

final class ErrorSurahInListeningMode extends ReadingState {
  final String message;

  const ErrorSurahInListeningMode({required this.message});
}

////reading mode
final class SurahLoadingInReadingMode extends ReadingState {}

final class SurahLoadedInReadingMode extends ReadingState {
  final SurahEntity surah;

  const SurahLoadedInReadingMode({required this.surah});
}

final class ErrorSurahInReadingMode extends ReadingState {
  final String message;

  const ErrorSurahInReadingMode({required this.message});
}
