import 'package:furqan/core/models/explain_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verse_taffsir_model.g.dart';

@JsonSerializable()
class VerseTaffsirModel {
  final String surahName;
  final int surahNo;
  final int ayahNo;
  final List<ExplainModel> tafsirs;

  VerseTaffsirModel({
    required this.surahName,
    required this.surahNo,
    required this.ayahNo,
    required this.tafsirs,
  });

  factory VerseTaffsirModel.fromJson(Map<String, dynamic> json) =>
      _$VerseTaffsirModelFromJson(json);
  Map<String, dynamic> toJson() => _$VerseTaffsirModelToJson(this);
}
