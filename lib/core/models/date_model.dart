import 'package:furqan/core/entities/date_entity.dart';
import 'package:json_annotation/json_annotation.dart';

// part 'date_model.g.dart';

@JsonSerializable()
class DateModel {
  final String readable;
  final String timestamp;
  final String arWeekDay;
  final String enWeekDay;

  DateModel({
    required this.readable,
    required this.timestamp,
    required this.arWeekDay,
    required this.enWeekDay,
  });

  factory DateModel.fromJson(Map<String, dynamic> json) {
    return DateModel(
      readable: json['readable'] ?? '',
      timestamp: json['timestamp'] ?? '',
      arWeekDay: json['hijri']?['weekday']?['ar'] ?? '',
      enWeekDay: json['hijri']?['weekday']?['en'] ?? '',
    );
  }
  Map<String, dynamic> toJson() => {
    'readable': readable,
    'timestamp': timestamp,
    'arWeekDay': arWeekDay,
    'enWeekDay': enWeekDay,
  };

  DateEntity toEntity() {
    return DateEntity(
      readable: readable,
      timestamp: timestamp,
      arWeekDay: arWeekDay,
      enWeekDay: enWeekDay,
    );
  }
}

// "readable": "21 Oct 2025",
// "timestamp": "1761019200",
// "hijri": {
// "date": "29-04-1447",
// "format": "DD-MM-YYYY",
// "day": "29",
// "weekday": {
// "en": "Al Thalaata",
// "ar": "الثلاثاء"
// },
// "month": {
// "number": 4,
// "en": "Rabīʿ al-thānī",
// "ar": "رَبيع الثاني",
// "days": 30
// },
// "year": "1447",
// "designation": {
// "abbreviated": "AH",
// "expanded": "Anno Hegirae"
// },
// "holidays": [],
// "adjustedHolidays": [],
// "method": "HJCoSA"
// },
