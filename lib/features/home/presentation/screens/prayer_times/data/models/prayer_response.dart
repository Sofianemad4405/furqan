import 'package:furqan/core/entities/prayer_response_entity.dart';
import 'package:furqan/core/models/date_model.dart';
import 'package:furqan/core/models/timings_model.dart';

class PrayerResponse {
  final TimingsModel timings;
  final DateModel date;
  final String timezone;

  PrayerResponse({
    required this.timings,
    required this.date,
    required this.timezone,
  });

  factory PrayerResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json;
    return PrayerResponse(
      timings: TimingsModel.fromJson(data['timings']),
      date: DateModel.fromJson(data['date']),
      timezone: data['meta']['timezone'],
    );
  }

  Map<String, dynamic> toJson() => {
    'timings': timings.toJson(),
    'date': date.toJson(),
    'timezone': timezone,
  };

  PrayerResponseEntity toEntity() {
    return PrayerResponseEntity(
      timings: timings.toEntity(),
      date: date.toEntity(),
      timezone: timezone,
    );
  }
}
