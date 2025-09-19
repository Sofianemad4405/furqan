import 'package:furqan/core/models/audio_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verse_model.g.dart';

@JsonSerializable()
class VerseModel {
  final String surahName;
  final String surahNameArabic;
  final String surahNameArabicLong;
  final String surahNameTranslation;
  final String revelationPlace;
  final String verseEnglish;
  final String verseArabic1;
  final String verseArabic2;
  final int totalAyah;
  final int ayahNo;
  final int surahNo;
  final Map<String, AudioModel> verseAudio;

  VerseModel({
    required this.surahName,
    required this.surahNameArabic,
    required this.surahNameArabicLong,
    required this.surahNameTranslation,
    required this.revelationPlace,
    required this.verseEnglish,
    required this.verseArabic1,
    required this.verseArabic2,
    required this.totalAyah,
    required this.ayahNo,
    required this.surahNo,
    required this.verseAudio,
  });

  factory VerseModel.fromJson(Map<String, dynamic> json) =>
      _$VerseModelFromJson(json);
  Map<String, dynamic> toJson() => _$VerseModelToJson(this);
}
