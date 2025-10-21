import 'dart:developer';

import 'package:furqan/core/entities/prayer_response_entity.dart';
import 'package:furqan/features/home/presentation/screens/prayer_times/data/prayer_times_abstract.dart';
import 'package:furqan/features/home/presentation/screens/prayer_times/domain/prayer_times_repo_abstract.dart';

class PrayerTimesRepoImpl implements PrayerTimesRepoAbstract {
  final PrayerTimesDataAbstract datasource;
  PrayerTimesRepoImpl(this.datasource);
  @override
  Future<PrayerResponseEntity> getPrayerTimings(
    String date,
    double latitude,
    double longitude,
    int method,
  ) async {
    try {
      final response = await datasource.getPrayerTimings(
        date,
        latitude,
        longitude,
        method,
      );
      return response.toEntity();
    } catch (e) {
      log("${e.toString()} in PrayerTimesRepoImpl");
      throw Exception(e.toString());
    }
  }
}
