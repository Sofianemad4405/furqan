import 'package:dio/dio.dart';
import 'package:furqan/core/models/azkar_section.dart';
import 'package:furqan/core/utils/constants.dart';
import 'package:furqan/core/utils/parse_error_logger.dart';
import 'package:retrofit/http.dart';

part 'adhkar_client.g.dart';

@RestApi(baseUrl: dhikrBaseUrl)
abstract class AdhkarClient {
  factory AdhkarClient(
    Dio dio, {
    String? baseUrl,
    ParseErrorLogger? errorLogger,
  }) = _AdhkarClient;

  @GET("/{category}.json")
  Future<AzkarSection> getAdhkar(@Path("category") String category);
}
