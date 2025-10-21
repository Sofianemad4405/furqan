import 'package:furqan/core/entities/prayer_response_entity.dart';

abstract class PrayerTimesRepoAbstract {
  Future<PrayerResponseEntity> getPrayerTimings(
    String date,
    double latitude,
    double longitude,
    int method,
  );
}
