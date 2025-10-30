import 'package:dio/dio.dart';
import 'package:furqan/core/models/tafsir_provider.dart';
import 'package:furqan/core/models/verse_tafsir.dart';
import 'package:furqan/core/utils/parse_error_logger.dart';
import 'package:retrofit/http.dart';

part 'tafsir_client.g.dart';

@RestApi(baseUrl: 'http://api.quran-tafseer.com')
abstract class TafsirClient {
  factory TafsirClient(Dio dio, {ParseErrorLogger? errorLogger}) =
      _TafsirClient;

  ///https://quranapi.pages.dev/api/tafseer/{tafseer_id}/{sura_number}/{ayah_number}
  @GET("/tafseer/{tafseerId}/{surahNo}/{ayahNumber}")
  Future<VerseTafsir> getVerseTafsir(
    @Path("tafseerId") int tafseerId,
    @Path("surahNo") int surahNo,
    @Path("ayahNumber") int ayahNumber,
  );

  ///https://quranapi.pages.dev/api/tafseer/
  @GET("/tafseer") // Remove trailing slash
  Future<List<TafsirProvider>> getTafsirList();
}
