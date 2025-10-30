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
  Future<Map<String, String>> getAvailableReciters();
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
    final url =
        "http://api.quran-tafseer.com/tafseer/$tafseerId/$surahNo/$ayahNumber";
    log("📡 Request URL: $url");

    try {
      final response = await _tafsirClient.getVerseTafsir(
        tafseerId,
        surahNo,
        ayahNumber,
      );

      log("✅ Response received: ${response.toJson()}");
      return response;
    } catch (e, stack) {
      log("❌ API Error: ${e.toString()}");
      log("📋 Stack trace: $stack");
      throw Exception("Failed to fetch tafsir: ${e.toString()}");
    }
  }

  @override
  Future<List<TafsirProvider>> getTafsirProviders() async {
    try {
      // log("🔄 ReadingDataSource: Making API call to get tafsir list...");
      // log(
      //   "🔄 ReadingDataSource: API URL: http://api.quran-tafseer.com/tafseer/",
      // );

      final response = await _tafsirClient.getTafsirList();

      log(
        "✅ ReadingDataSource: API call successful, got ${response.length} tafsir providers",
      );

      if (response.isNotEmpty) {
        log("📋 ReadingDataSource: First provider: ${response[0].toJson()}");
      } else {
        log("kiiaan no tafsir providers");
      }

      return response;
    } catch (e) {
      log("❌ ReadingDataSource: API call failed: ${e.toString()}");
      log("❌ ReadingDataSource: Error type: ${e.runtimeType}");
      throw Exception(e.toString());
    }
  }

  @override
  Future<Map<String, String>> getAvailableReciters() async {
    try {
      final reciters = await _api.getAvailableReciters();
      return reciters;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
