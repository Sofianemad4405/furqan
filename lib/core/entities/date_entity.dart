import 'package:furqan/core/models/date_model.dart';

class DateEntity {
  final String readable;
  final String timestamp;
  final String arWeekDay;
  final String enWeekDay;

  DateEntity({
    required this.readable,
    required this.timestamp,
    required this.arWeekDay,
    required this.enWeekDay,
  });

  DateModel toModel() {
    return DateModel(
      readable: readable,
      timestamp: timestamp,
      arWeekDay: arWeekDay,
      enWeekDay: enWeekDay,
    );
  }
}
