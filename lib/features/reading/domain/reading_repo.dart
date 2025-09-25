import 'package:furqan/core/entities/surah_entity.dart';
import 'package:furqan/features/reading/data/reading_data_source.dart';
import 'package:furqan/features/reading/domain/entities/surah_base_entity.dart';

abstract class ReadingRepo {
  Future<List<SurahBaseEntity>> getSurahs();
  Future<SurahEntity> getSurahWithAudioAndTranslation(int surahNo);
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
}
