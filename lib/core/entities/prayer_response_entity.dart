import 'package:furqan/core/entities/date_entity.dart';
import 'package:furqan/core/entities/timings_entity.dart';
import 'package:furqan/features/home/presentation/screens/prayer_times/data/models/prayer_response.dart';

class PrayerResponseEntity {
  final TimingsEntity timings;
  final DateEntity date;
  final String timezone;

  PrayerResponseEntity({
    required this.timings,
    required this.date,
    required this.timezone,
  });

  PrayerResponse toModel() {
    return PrayerResponse(
      timings: timings.toModel(),
      date: date.toModel(),
      timezone: timezone,
    );
  }
}
