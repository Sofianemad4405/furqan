import 'package:furqan/core/models/surah_base.dart';
import 'package:furqan/core/models/surah_model.dart';
import 'package:furqan/core/network/retrofit_client.dart';

abstract class ReadingDataSource {
  Future<List<SurahBase>> getSurahs();
  Future<SurahModel> getSurahWithAudioAndTranslation(int surahNo);
}

class ReadingDataSourceImpl implements ReadingDataSource {
  final ApiService _api;
  ReadingDataSourceImpl(this._api);
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
}
