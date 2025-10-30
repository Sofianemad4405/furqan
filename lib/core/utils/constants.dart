const String baseUrl = "https://quranapi.pages.dev/api";
const String tafsirBaseUrl = "http://api.quran-tafseer.com";
const String dhikrBaseUrl = "https://ahegazy.github.io/muslimKit/json";
const String prayerTimesBaseUrl = "https://api.aladhan.com/v1/timings";
const String arabic1 = "arabic1";
const String arabic2 = "arabic2";
const String bengali = "bengali";
const String urdu = "urdu";
const String turkish = "turkish";
const String uzbek = "uzbek";

///days chars
const List<String> days = ["SU", "M", "T", "W", "TH", "F", "SA"];

///Main challenges
// List<MainChallenge> mainChallenges = [
//   MainChallenge(
//     challengeIcon: "📚",
//     challengeName: "Continue Reading",
//     challengeDesc: "Start your journey",
//   ),
//   MainChallenge(
//     challengeIcon: "🤲",
//     challengeName: "Duas",
//     challengeDesc: "Recite your daily duas",
//   ),
//   MainChallenge(
//     challengeIcon: "✨",
//     challengeName: "Dhikr Counter",
//     challengeDesc: "Keep track of your dhikr",
//   ),
//   MainChallenge(
//     challengeIcon: "🕌",
//     challengeName: "Prayer Times",
//     challengeDesc: '',
//   ),
// ];

// List<ChallengeModel> todayChallenges = [
//   ChallengeModel(
//     challengeIcon: "📖",
//     challengeName: "Complete a Surah",
//     challengeDesc: "Read any complete Surah today",
//     challengeCompletion: 1,
//   ),
//   ChallengeModel(
//     challengeIcon: "❤️",
//     challengeName: "Act of Kindness",
//     challengeDesc: "Perform one act of charity or kindness",
//     challengeCompletion: 1,
//   ),
//   ChallengeModel(
//     challengeIcon: "📖",
//     challengeName: "Read 5 Ayahs",
//     challengeDesc: "Read at least 5 Ayahs with reflection",
//     challengeCompletion: 5,
//   ),
// ];

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

List<String> surahIcons = [
  "🙏", // الفاتحة
  "🐄", // البقرة
  "👨‍👩‍👧", // آل عمران
  "👩", // النساء
  "🍽️", // المائدة
  "🐑", // الأنعام
  "🏔️", // الأعراف
  "⚔️", // الأنفال
  "🤲", // التوبة
  "🛶", // يونس
  "🌊", // هود
  "👕", // يوسف
  "⚡", // الرعد
  "🔥", // إبراهيم
  "🪨", // الحجر
  "🐝", // النحل
  "🌙", // الإسراء
  "🕯️", // الكهف
  "👶", // مريم
  "🧑‍🤝‍🧑", // طه
  "👑", // الأنبياء
  "🕋", // الحج
  "🤲", // المؤمنون
  "💡", // النور
  "⚖️", // الفرقان
  "✍️", // الشعراء
  "🐜", // النمل
  "📖", // القصص
  "🕸️", // العنكبوت
  "🏛️", // الروم
  "👴", // لقمان
  "🙇", // السجدة
  "🏰", // الأحزاب
  "🐪", // سبأ
  "🌱", // فاطر
  "❤️", // يس
  "👼", // الصافات
  "🗡️", // ص
  "👥", // الزمر
  "😇", // غافر
  "📜", // فصلت
  "🤝", // الشورى
  "💎", // الزخرف
  "🌫️", // الدخان
  "🧎", // الجاثية
  "⛰️", // الأحقاف
  "☪️", // محمد
  "🗝️", // الفتح
  "🚪", // الحجرات
  "🌌", // ق
  "💨", // الذاريات
  "🏔️", // الطور
  "⭐", // النجم
  "🌙", // القمر
  "🌹", // الرحمن
  "💥", // الواقعة
  "⚒️", // الحديد
  "🗣️", // المجادلة
  "🏕️", // الحشر
  "🕵️", // الممتحنة
  "🪖", // الصف
  "📿", // الجمعة
  "🎭", // المنافقون
  "🔄", // التغابن
  "💔", // الطلاق
  "🚫", // التحريم
  "👑", // الملك
  "✒️", // القلم
  "📢", // الحاقة
  "🛤️", // المعارج
  "⛵", // نوح
  "👻", // الجن
  "🛌", // المزمل
  "🧥", // المدثر
  "⚖️", // القيامة
  "🧑", // الإنسان
  "🕊️", // المرسلات
  "📣", // النبأ
  "⚡", // النازعات
  "🙁", // عبس
  "🌅", // التكوير
  "🌌", // الانفطار
  "⚖️", // المطففين
  "🌠", // الانشقاق
  "🏯", // البروج
  "🌟", // الطارق
  "⬆️", // الأعلى
  "😰", // الغاشية
  "🌄", // الفجر
  "🏙️", // البلد
  "☀️", // الشمس
  "🌃", // الليل
  "🌞", // الضحى
  "❤️", // الشرح
  "🍇", // التين
  "🩸", // العلق
  "✨", // القدر
  "📜", // البينة
  "🌍", // الزلزلة
  "🐎", // العاديات
  "🥁", // القارعة
  "💰", // التكاثر
  "⏳", // العصر
  "👄", // الهمزة
  "🐘", // الفيل
  "🐪", // قريش
  "🍲", // الماعون
  "🏞️", // الكوثر
  "🚷", // الكافرون
  "🕊️", // النصر
  "🪵", // المسد
  "☝️", // الإخلاص
  "🌅", // الفلق
  "👥", // الناس
];

List<String> recitersImgs = [
  "assets/imgs/mashary.png",
  "assets/imgs/abubakr.png",
  "assets/imgs/nasser.png",
  "assets/imgs/yasser.png",
  "assets/imgs/hany.png",
];

final List<String> nationalities = [
  "Kuwaiti",
  "Saudi",
  "Saudi",
  "Saudi",
  "Saudi",
];
