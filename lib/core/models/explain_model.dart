import 'package:json_annotation/json_annotation.dart';
part 'explain_model.g.dart';

@JsonSerializable()
class ExplainModel {
  final String author;
  final String? groupVerse;
  final String content;

  ExplainModel({
    required this.author,
    required this.groupVerse,
    required this.content,
  });

  factory ExplainModel.fromJson(Map<String, dynamic> json) =>
      _$ExplainModelFromJson(json);
  Map<String, dynamic> toJson() => _$ExplainModelToJson(this);
}
