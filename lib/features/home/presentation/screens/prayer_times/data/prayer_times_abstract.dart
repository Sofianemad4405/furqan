import 'package:furqan/features/home/presentation/screens/prayer_times/data/models/prayer_response.dart';

abstract class PrayerTimesDataAbstract {
  Future<PrayerResponse> getPrayerTimings(
    String date,
    double latitude,
    double longitude,
    int method,
  );
}
