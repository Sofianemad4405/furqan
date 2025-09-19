import 'package:furqan/core/models/audio_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'surah_model.g.dart';

@JsonSerializable()
class SurahModel {
  final String surahName;
  final String surahNameArabic;
  final String surahNameArabicLong;
  final String surahNameTranslation;
  final String revelationPlace;
  final int totalAyah;
  final int surahNo;
  final Map<String, AudioModel> surahAudio;
  final Map<String, AudioModel> verseAudio;
  final List<String> translation;

  SurahModel({
    required this.surahName,
    required this.surahNameArabic,
    required this.surahNameArabicLong,
    required this.surahNameTranslation,
    required this.revelationPlace,
    required this.totalAyah,
    required this.surahNo,
    required this.surahAudio,
    required this.verseAudio,
    required this.translation,
  });

  factory SurahModel.fromJson(Map<String, dynamic> json) =>
      _$SurahModelFromJson(json);
  Map<String, dynamic> toJson() => _$SurahModelToJson(this);
}
