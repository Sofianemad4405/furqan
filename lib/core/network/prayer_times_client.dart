import 'package:dio/dio.dart';
import 'package:furqan/core/utils/constants.dart';
import 'package:furqan/core/utils/parse_error_logger.dart';
import 'package:furqan/features/home/presentation/screens/prayer_times/data/models/prayer_response.dart';
import 'package:retrofit/http.dart';

part 'prayer_times_client.g.dart';

@RestApi(baseUrl: prayerTimesBaseUrl)
abstract class PrayerTimesClient {
  factory PrayerTimesClient(
    Dio dio, {
    String? baseUrl,
    ParseErrorLogger? errorLogger,
  }) = _PrayerTimesClient;

  ///https://api.aladhan.com/v1/timings/21-10-2025?latitude=30.5727787&longitude=31.582086&method=2
  @GET("/timings/{date}")
  Future<PrayerResponse> getPrayerTimings(
    @Path("date") String date,
    @Query("latitude") double latitude,
    @Query("longitude") double longitude,
    @Query("method") int method,
  );
}
