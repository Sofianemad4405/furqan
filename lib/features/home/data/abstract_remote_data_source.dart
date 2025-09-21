import 'package:furqan/core/models/audio_model.dart';
import 'package:furqan/core/models/surah_base.dart';
import 'package:furqan/core/models/surah_detail_model.dart';
import 'package:furqan/core/models/surah_model.dart';

abstract class RemoteDataSource {
  Future<List<SurahBase>> getSurahs();
  Future<SurahModel> getSurahWithAudioAndTranslation(int surahNo);
  Future<SurahDetailModel> getVerse(int surahNo, int ayahNo);
  Future<Map<String, String>> getAvailableReciters();
  Future<Map<String, AudioModel>> getVerseAudio(int surahNo, int ayahNo);
}
