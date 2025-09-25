import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:furqan/core/entities/surah_entity.dart';
import 'package:furqan/features/reading/domain/entities/surah_base_entity.dart';
import 'package:furqan/features/reading/domain/reading_repo.dart';

part 'reading_state.dart';

class ReadingCubit extends Cubit<ReadingState> {
  ReadingCubit(this._readingRepo) : super(ReadingInitial());
  final ReadingRepo _readingRepo;

  Future<void> getSurahs() async {
    emit(SurahsLoading());
    try {
      log("message");
      final surahs = await _readingRepo.getSurahs();
      emit(ChoosingSurah(surahs: surahs));
    } catch (e) {
      emit(ErrorChoosingSurah(message: e.toString()));
    }
  }

  void toggleToChoosingMode(int surahNo, String surahName) {
    emit(ChoosingMode(surahNo: surahNo, surahName: surahName));
  }

  void toggleToSurahSelectionMode() {
    emit(ReadingInitial());
  }

  Future<SurahEntity> getSurah(int surahNo) async {
    final surah = await _readingRepo.getSurahWithAudioAndTranslation(surahNo);
    return surah;
  }

  Future<void> getSurahWithAudioAndTranslation(int surahNo) async {
    emit(SurahLoading());
    try {
      final surah = await _readingRepo.getSurahWithAudioAndTranslation(surahNo);
      emit(SurahLoaded(surah: surah));
    } catch (e) {
      emit(ErrorSurah(message: e.toString()));
    }
  }
}
