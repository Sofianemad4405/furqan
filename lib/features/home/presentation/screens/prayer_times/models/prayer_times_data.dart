import 'package:furqan/features/home/presentation/screens/prayer_times/models/location_data.dart';
import 'package:furqan/features/home/presentation/screens/prayer_times/models/prayer_times.dart';

class PrayerTimesData {
  final DateTime date;
  final PrayerTimes times;
  final LocationData location;

  PrayerTimesData({
    required this.date,
    required this.times,
    required this.location,
  });
}
