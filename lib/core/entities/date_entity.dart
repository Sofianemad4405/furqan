import 'package:furqan/core/models/date_model.dart';

class DateEntity {
  final String readable;
  final String timestamp;
  final Map<String, String> weekDay;

  DateEntity({
    required this.readable,
    required this.timestamp,
    required this.weekDay,
  });

  DateModel toModel() {
    return DateModel(
      readable: readable,
      timestamp: timestamp,
      weekDay: weekDay,
    );
  }
}
