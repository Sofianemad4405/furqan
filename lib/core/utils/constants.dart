import 'package:furqan/features/home/presentation/models/stat_model.dart';
import 'package:furqan/features/home/presentation/screens/home_screen.dart';

const String baseUrl = "https://quranapi.pages.dev/api";
const String arabic1 = "arabic1";
const String arabic2 = "arabic2";
const String bengali = "bengali";
const String urdu = "urdu";
const String turkish = "turkish";
const String uzbek = "uzbek";

///days chars
const List<String> days = ["SU", "M", "T", "W", "TH", "F", "SA"];

///Home Stats
final Map<String, String> homeStats = {
  "Hasanat": "🌙",
  "Surahs": "🌙",
  "Minutes": "🌙",
};
