import 'dart:developer';

import 'package:furqan/core/entities/audio_entity.dart';
import 'package:furqan/core/entities/surah_entity.dart';
import 'package:furqan/core/entities/tafsir_entity.dart';
import 'package:furqan/features/reading/data/reading_data_source.dart';
import 'package:furqan/features/reading/domain/entities/surah_base_entity.dart';
import 'package:furqan/features/reading/domain/entities/tafsir_provider_entity.dart';

abstract class ReadingRepo {
  Future<List<SurahBaseEntity>> getSurahs();
  Future<SurahEntity> getSurahWithAudioAndTranslation(int surahNo);
  Future<Map<String, AudioEntity>> getVerseAudio(int surahNo, int ayahNo);
  Future<VerseTafsirEntity> getVerseTafsir(
    int tafseerId,
    int surahNo,
    int ayahNo,
  );
  Future<List<TafsirProviderEntity>> getTafsirProviders();
  Future<Map<String, String>> getAvailableReciters();
}

class ReadingRepoImpl implements ReadingRepo {
  final ReadingDataSource _dataSource;
  ReadingRepoImpl(this._dataSource);
  @override
  Future<List<SurahBaseEntity>> getSurahs() async {
    final surahs = await _dataSource.getSurahs();
    return surahs.map((surah) => surah.baseToEntity()).toList();
  }

  @override
  Future<SurahEntity> getSurahWithAudioAndTranslation(int surahNo) async {
    final surah = await _dataSource.getSurahWithAudioAndTranslation(surahNo);
    return surah.modelToEntity();
  }

  @override
  Future<Map<String, AudioEntity>> getVerseAudio(
    int surahNo,
    int ayahNo,
  ) async {
    final verseAudio = await _dataSource.getVerseAudio(surahNo, ayahNo);
    return verseAudio.map((key, value) => MapEntry(key, value.toEntity()));
  }

  @override
  Future<VerseTafsirEntity> getVerseTafsir(
    int tafseerId,
    int surahNo,
    int ayahNo,
  ) async {
    final verseTafsir = await _dataSource.getVerseTafsir(
      tafseerId,
      surahNo,
      ayahNo,
    );
    return verseTafsir.toEntity();
  }

  @override
  Future<List<TafsirProviderEntity>> getTafsirProviders() async {
    try {
      log("🔄 ReadingRepo: Calling data source to get tafsir providers...");
      final tafsirProviders = await _dataSource.getTafsirProviders();
      log(
        "✅ ReadingRepo: Data source returned ${tafsirProviders.length} tafsir providers",
      );

      final entities = tafsirProviders
          .map((tafsirProvider) => tafsirProvider.toEntity())
          .toList();

      log("✅ ReadingRepo: Converted to ${entities.length} entities");
      return entities;
    } catch (e) {
      log("❌ ReadingRepo: Error in getTafsirProviders: ${e.toString()}");
      log("❌ ReadingRepo: Error type: ${e.runtimeType}");
      return [];
    }
  }

  @override
  Future<Map<String, String>> getAvailableReciters() async {
    try {
      final reciters = await _dataSource.getAvailableReciters();
      return reciters;
    } catch (e) {
      log("error in getAvailableReciters ${e.toString()}");
      return {};
    }
  }
}
