import 'package:dio/dio.dart';
import 'package:furqan/core/models/verse_tafsir.dart';
import 'package:furqan/core/utils/parse_error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:furqan/core/utils/constants.dart';

part 'tafsir_client.g.dart';

@RestApi(baseUrl: tafsirBaseUrl)
abstract class TafsirClient {
  factory TafsirClient(
    Dio dio, {
    String? tafsirBaseUrl,
    ParseErrorLogger? errorLogger,
  }) = _TafsirClient;

  ///http://api.quran-tafseer.com/tafseer/1/1/1
  ///api.quran-tafseer.com/tafseer/{tafseer_id}/{sura_number}/{ayah_number}
  @GET("/{tafseerId}/{surahNo}/{ayahNumber}")
  Future<VerseTafsir> getVerseTafsir(
    @Path("tafseerId") int tafseerId,
    @Path("surahNo") int surahNo,
    @Path("ayahNumber") int ayahNumber,
  );
}
