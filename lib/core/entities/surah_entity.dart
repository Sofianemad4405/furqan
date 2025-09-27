import 'package:furqan/core/entities/audio_entity.dart';

class SurahEntity {
  final int surahNo;
  final String surahName;
  final String surahNameArabic;
  final String surahNameArabicLong;
  final String surahNameTranslation;
  final String revelationPlace;
  final int totalAyah;
  final Map<String, AudioEntity> surahAudio;
  final List<String>? english;
  final List<String>? arabic1;
  final List<String>? arabic2;
  final List<String>? bengali;
  final List<String>? urdu;
  final List<String>? turkish;
  final List<String>? uzbek;

  SurahEntity({
    required this.surahNo,
    required this.surahName,
    required this.surahNameArabic,
    required this.surahNameArabicLong,
    required this.surahNameTranslation,
    required this.revelationPlace,
    required this.totalAyah,
    required this.surahAudio,
    required this.english,
    required this.arabic1,
    required this.arabic2,
    required this.bengali,
    required this.urdu,
    required this.turkish,
    required this.uzbek,
  });
}
