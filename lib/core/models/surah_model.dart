import 'package:furqan/core/entities/surah_entity.dart';
import 'package:furqan/core/models/audio_model.dart';
import 'package:furqan/core/models/surah_base.dart';
import 'package:json_annotation/json_annotation.dart';
part 'surah_model.g.dart';

@JsonSerializable()
class SurahModel extends SurahBase {
  final int surahNo;
  final Map<String, AudioModel> audio;
  final List<String>? english;
  final List<String>? arabic1;
  final List<String>? arabic2;
  final List<String>? bengali;
  final List<String>? urdu;
  final List<String>? turkish;
  final List<String>? uzbek;

  SurahModel({
    required super.surahName,
    required super.surahNameArabic,
    required super.surahNameArabicLong,
    required super.surahNameTranslation,
    required super.revelationPlace,
    required super.totalAyah,
    required this.audio,
    required this.english,
    required this.arabic1,
    required this.arabic2,
    required this.bengali,
    required this.urdu,
    required this.turkish,
    required this.uzbek,
    required this.surahNo,
  });
  factory SurahModel.fromJson(Map<String, dynamic> json) =>
      _$SurahModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SurahModelToJson(this);
  SurahEntity modelToEntity() {
    return SurahEntity(
      surahNo: surahNo,
      surahName: surahName,
      surahNameArabic: surahNameArabic,
      surahNameArabicLong: surahNameArabicLong,
      surahNameTranslation: surahNameTranslation,
      revelationPlace: revelationPlace,
      totalAyah: totalAyah,
      surahAudio: audio.map((key, value) => MapEntry(key, value.toEntity())),
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
