import 'package:furqan/core/models/explain_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'surah_detail_model.g.dart';

@JsonSerializable()
class SurahDetailModel {
  final String surahName;
  final int surahNo;
  final int ayahNo;
  final List<ExplainModel> tafsirs;

  SurahDetailModel({
    required this.surahName,
    required this.surahNo,
    required this.ayahNo,
    required this.tafsirs,
  });

  factory SurahDetailModel.fromJson(Map<String, dynamic> json) =>
      _$SurahDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$SurahDetailModelToJson(this);
}
