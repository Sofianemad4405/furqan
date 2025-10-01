import 'package:dio/dio.dart';
import 'package:furqan/core/models/audio_model.dart';
import 'package:furqan/core/models/surah_detail_model.dart';
import 'package:furqan/core/models/surah_model.dart';
import 'package:furqan/core/utils/endpoints.dart';
import 'package:retrofit/http.dart';
import 'package:furqan/core/utils/constants.dart';
import 'package:furqan/core/models/surah_base.dart';
import 'package:furqan/core/utils/parse_error_logger.dart';

part 'retrofit_client.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class ApiService {
  factory ApiService(
    Dio dio, {
    String? baseUrl,
    ParseErrorLogger? errorLogger,
  }) = _ApiService;

  @GET("/${Endpoints.allSurahs}")
  Future<List<SurahBase>> getSurahs();

  // https://quranapi.pages.dev/api/4.json
  @GET("/{surahNo}.json")
  Future<SurahModel> getSurahWithAudioAndTranslation(
    @Path("surahNo") int surahNo,
  );

  //https://quranapi.pages.dev/api/tafsir/19_56.json
  @GET("/tafsir/{surahNo}_{ayahNo}.json")
  Future<SurahDetailModel> getVerse(
    @Path("surahNo") int surahNo,
    @Path("ayahNo") int ayahNo,
  );

  ///https://quranapi.pages.dev/api/reciters.json
  @GET("/reciters.json")
  Future<Map<String, String>> getAvailableReciters();

  // https://quranapi.pages.dev/api/1/2.json
  ///https://quranapi.pages.dev/api/audio/2/1.json
  @GET("/audio/{surahNo}/{ayahNo}.json")
  Future<Map<String, AudioModel>> getVerseAudio(
    @Path("surahNo") int surahNo,
    @Path("ayahNo") int ayahNo,
  );
}
