class SurahEntity {
  final int surahNo;
  final String surahName;
  final String surahNameArabic;
  final String surahNameArabicLong;
  final String surahNameTranslation;
  final String revelationPlace;
  final int totalAyah;
  final Map<String, String> surahAudio;
  final Map<String, List<String>> translations;

  SurahEntity({
    required this.surahNo,
    required this.surahName,
    required this.surahNameArabic,
    required this.surahNameArabicLong,
    required this.surahNameTranslation,
    required this.revelationPlace,
    required this.totalAyah,
    required this.surahAudio,
    required this.translations,
  });
}
