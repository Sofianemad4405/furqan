import 'package:furqan/core/entities/surah_entity.dart';
import 'package:furqan/core/models/surah_model.dart';

extension SurahMapper on SurahModel {
  SurahEntity toEntity() {
    return SurahEntity(
      surahNo: surahNo,
      surahName: surahName,
      surahNameArabic: surahNameArabic,
      surahNameArabicLong: surahNameArabicLong,
      surahNameTranslation: surahNameTranslation,
      revelationPlace: revelationPlace,
      totalAyah: totalAyah,
      surahAudio: audio.map((k, v) => MapEntry(k, v.toEntity())),
      english: english ?? [],
      arabic1: arabic1 ?? [],
      arabic2: arabic2 ?? [],
      bengali: bengali ?? [],
      urdu: urdu ?? [],
      turkish: turkish ?? [],
      uzbek: uzbek ?? [],
    );
  }
}
