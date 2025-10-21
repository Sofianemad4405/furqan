import 'package:furqan/core/entities/timings_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'timings_model.g.dart';

@JsonSerializable()
class TimingsModel {
  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String sunset;
  final String maghrib;
  final String isha;
  final String imsak;
  final String midnight;
  final String firstthird;
  final String lastthird;

  TimingsModel({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.sunset,
    required this.maghrib,
    required this.isha,
    required this.imsak,
    required this.midnight,
    required this.firstthird,
    required this.lastthird,
  });

  factory TimingsModel.fromJson(Map<String, dynamic> json) =>
      _$TimingsModelFromJson(json);
  Map<String, dynamic> toJson() => _$TimingsModelToJson(this);

  TimingsEntity toEntity() {
    return TimingsEntity(
      fajr: fajr,
      sunrise: sunrise,
      dhuhr: dhuhr,
      asr: asr,
      sunset: sunset,
      maghrib: maghrib,
      isha: isha,
      imsak: imsak,
      midnight: midnight,
      firstthird: firstthird,
      lastthird: lastthird,
    );
  }
}

// "Fajr": "05:54",
// "Sunrise": "07:00",
// "Dhuhr": "12:38",
// "Asr": "15:51",
// "Sunset": "18:16",
// "Maghrib": "18:16",
// "Isha": "19:22",
// "Imsak": "05:44",
// "Midnight": "00:38",
// "Firstthird": "22:31",
// "Lastthird": "02:45"
