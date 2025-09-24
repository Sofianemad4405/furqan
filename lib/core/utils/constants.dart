import 'package:furqan/core/themes/theme_system.dart';
import 'package:furqan/features/home/presentation/models/challenge_model.dart';
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

///Main challenges
List<ChallengeModel> mainChallenges = [
  ChallengeModel(
    challengeIcon: "📚",
    challengeName: "Continue Reading",
    challengeDesc: "Start your journey",
  ),
  ChallengeModel(challengeIcon: "🤲", challengeName: "Duas"),
  ChallengeModel(challengeIcon: "✨", challengeName: "Dhikr Counter"),
  ChallengeModel(challengeIcon: "🕌", challengeName: "Prayer Times"),
];

List<ChallengeModel> todayChallenges = [
  ChallengeModel(
    challengeIcon: "📖",
    challengeName: "Complete a Surah",
    challengeDesc: "Read any complete Surah today",
    challengeCompletion: 1,
  ),
  ChallengeModel(
    challengeIcon: "❤️",
    challengeName: "Act of Kindness",
    challengeDesc: "Perform one act of charity or kindness",
    challengeCompletion: 1,
  ),
  ChallengeModel(
    challengeIcon: "📖",
    challengeName: "Read 5 Ayahs",
    challengeDesc: "Read at least 5 Ayahs with reflection",
    challengeCompletion: 5,
  ),
];
