import 'dart:developer';

import 'package:furqan/core/network/prayer_times_client.dart';
import 'package:furqan/features/home/presentation/screens/prayer_times/data/models/prayer_response.dart';
import 'package:furqan/features/home/presentation/screens/prayer_times/data/prayer_times_abstract.dart';

class PrayerTimesImpl implements PrayerTimesDataAbstract {
  final PrayerTimesClient prayerTimesClient;
  PrayerTimesImpl({required this.prayerTimesClient});

  @override
  Future<PrayerResponse> getPrayerTimings(
    String date,
    double latitude,
    double longitude,
    int method,
  ) {
    try {
      return prayerTimesClient.getPrayerTimings(
        date,
        latitude,
        longitude,
        method,
      );
    } on Exception catch (e) {
      log("${e.toString()} in PrayerTimesImpl");
      throw Exception(e.toString());
    }
  }
}
