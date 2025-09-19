import 'package:furqan/core/models/audio_model.dart';
import 'package:furqan/core/models/surah_base.dart';
import 'package:json_annotation/json_annotation.dart';
part 'surah_model.g.dart';

@JsonSerializable()
class SurahModel extends SurahBase {
  final int surahNo;
  final Map<String, AudioModel> surahAudio;
  final List<String> english;
  final List<String> arabic1;
  final List<String> arabic2;
  final List<String> bengali;
  final List<String> urdu;
  final List<String> turkish;
  final List<String> uzbek;

  SurahModel({
    required super.surahName,
    required super.surahNameArabic,
    required super.surahNameArabicLong,
    required super.surahNameTranslation,
    required super.revelationPlace,
    required super.totalAyah,
    required this.surahNo,
    required this.surahAudio,
    required this.english,
    required this.arabic1,
    required this.arabic2,
    required this.bengali,
    required this.urdu,
    required this.turkish,
    required this.uzbek,
  });
  factory SurahModel.fromJson(Map<String, dynamic> json) =>
      _$SurahModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SurahModelToJson(this);
}
