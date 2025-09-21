import 'package:furqan/core/models/audio_model.dart';
import 'package:furqan/core/models/surah_base.dart';
import 'package:furqan/core/models/surah_detail_model.dart';
import 'package:furqan/core/models/surah_model.dart';
import 'package:furqan/core/network/retrofit_client.dart';
import 'package:furqan/features/home/data/abstract_remote_data_source.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  final ApiService apiService;
  RemoteDataSourceImpl(this.apiService);
  @override
  Future<Map<String, String>> getAvailableReciters() {
    return apiService.getAvailableReciters();
  }

  @override
  Future<SurahModel> getSurahWithAudioAndTranslation(int surahNo) {
    return apiService.getSurahWithAudioAndTranslation(surahNo);
  }

  @override
  Future<List<SurahBase>> getSurahs() {
    return apiService.getSurahs();
  }

  @override
  Future<SurahDetailModel> getVerse(int surahNo, int ayahNo) {
    return apiService.getVerse(surahNo, ayahNo);
  }

  @override
  Future<Map<String, AudioModel>> getVerseAudio(int surahNo, int ayahNo) {
    return apiService.getVerseAudio(surahNo, ayahNo);
  }
}
