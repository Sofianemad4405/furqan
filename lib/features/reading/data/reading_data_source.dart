import 'dart:developer';

import 'package:furqan/core/models/audio_model.dart';
import 'package:furqan/core/models/surah_base.dart';
import 'package:furqan/core/models/surah_model.dart';
import 'package:furqan/core/models/tafsir_provider.dart';
import 'package:furqan/core/models/verse_tafsir.dart';
import 'package:furqan/core/network/retrofit_client.dart';
import 'package:furqan/core/network/tafsir_client.dart';

abstract class ReadingDataSource {
  Future<List<SurahBase>> getSurahs();
  Future<SurahModel> getSurahWithAudioAndTranslation(int surahNo);
  Future<Map<String, AudioModel>> getVerseAudio(int surahNo, int ayahNo);
  Future<VerseTafsir> getVerseTafsir(
    int tafseerId,
    int surahNo,
    int ayahNumber,
  );
  Future<List<TafsirProvider>> getTafsirProviders();
  Future<List<String>> getAvailableReciters();
}

class ReadingDataSourceImpl implements ReadingDataSource {
  final ApiService _api;
  final TafsirClient _tafsirClient;
  ReadingDataSourceImpl(this._api, this._tafsirClient);
  @override
  Future<List<SurahBase>> getSurahs() async {
    try {
      final response = await _api.getSurahs();
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<SurahModel> getSurahWithAudioAndTranslation(int surahNo) async {
    try {
      final response = await _api.getSurahWithAudioAndTranslation(surahNo);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Map<String, AudioModel>> getVerseAudio(int surahNo, int ayahNo) async {
    try {
      final response = await _api.getVerseAudio(surahNo, ayahNo);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<VerseTafsir> getVerseTafsir(
    int tafseerId,
    int surahNo,
    int ayahNumber,
  ) async {
    log(
      "URL => http://api.quran-tafseer.com/tafseer/$tafseerId/$surahNo/$ayahNumber",
    );
    try {
      final response = await _tafsirClient.getVerseTafsir(
        tafseerId,
        surahNo,
        ayahNumber,
      );
      log("koko ${response.toString()}");
      return response;
    } catch (e) {
      log("kokii ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<TafsirProvider>> getTafsirProviders() async {
    try {
      final response = await _tafsirClient.getTafsirList();
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<String>> getAvailableReciters() async {
    try {
      final reciters = await _api.getAvailableReciters();
      return reciters.values.toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
