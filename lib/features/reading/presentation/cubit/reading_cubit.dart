import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:furqan/core/entities/audio_entity.dart';
import 'package:furqan/core/entities/surah_entity.dart';
import 'package:furqan/core/entities/tafsir_entity.dart';
import 'package:furqan/features/reading/domain/entities/surah_base_entity.dart';
import 'package:furqan/features/reading/domain/entities/tafsir_provider_entity.dart';
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
    emit(SurahLoadingInReadingMode());
    try {
      final surah = await _readingRepo.getSurahWithAudioAndTranslation(surahNo);
      emit(SurahLoadedInReadingMode(surah: surah));
    } catch (e) {
      emit(ErrorSurahInReadingMode(message: e.toString()));
    }
  }

  Future<List<AudioEntity>> getVerseAudios(int surahNo, int ayahNo) async {
    final audio = await _readingRepo.getVerseAudio(surahNo, ayahNo);
    return audio.values.toList();
  }

  Future<VerseTafsirEntity> getVerseTafsir(
    int tafseerId,
    int surahNo,
    int ayahNo,
  ) async {
    try {
      final verseTafsir = await _readingRepo.getVerseTafsir(
        tafseerId,
        surahNo,
        ayahNo,
      );
      return verseTafsir;
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<List<TafsirProviderEntity>> getTafsirProviders() async {
    final tafsirProviders = await _readingRepo.getTafsirProviders();
    return tafsirProviders;
  }
}
