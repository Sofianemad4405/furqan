import 'package:furqan/features/reading/domain/entities/surah_base_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'surah_base.g.dart';

@JsonSerializable()
class SurahBase {
  final String surahName;
  final String surahNameArabic;
  final String surahNameArabicLong;
  final String surahNameTranslation;
  final String revelationPlace;
  final int totalAyah;
  SurahBase({
    required this.surahName,
    required this.surahNameArabic,
    required this.surahNameArabicLong,
    required this.surahNameTranslation,
    required this.revelationPlace,
    required this.totalAyah,
  });

  factory SurahBase.fromJson(Map<String, dynamic> json) =>
      _$SurahBaseFromJson(json);
  Map<String, dynamic> toJson() => _$SurahBaseToJson(this);
  SurahBaseEntity baseToEntity() => SurahBaseEntity(
    surahName: surahName,
    surahNameArabic: surahNameArabic,
    surahNameArabicLong: surahNameArabicLong,
    surahNameTranslation: surahNameTranslation,
    revelationPlace: revelationPlace,
    totalAyah: totalAyah,
  );
}
