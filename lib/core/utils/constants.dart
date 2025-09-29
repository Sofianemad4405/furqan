import 'package:furqan/features/home/presentation/models/challenge_model.dart';

const String baseUrl = "https://quranapi.pages.dev/api";
const String tafsirBaseUrl = "http://api.quran-tafseer.com";
const String dhikrBaseUrl = "https://ahegazy.github.io/muslimKit/json";
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

List<String> azkarCategories = [
  "أذكار الصباح",
  "أذكار المساء",
  "أذكار بعد الصلاة",
];

List<String> azkarCategoriesEnglish = [
  "Morning Azkar",
  "Evening Azkar",
  "Post Prayer Azkar",
];
