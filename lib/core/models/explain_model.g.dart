// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'explain_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExplainModel _$ExplainModelFromJson(Map<String, dynamic> json) => ExplainModel(
      author: json['author'] as String,
      groupVerse: json['groupVerse'] as String?,
      content: json['content'] as String,
    );

Map<String, dynamic> _$ExplainModelToJson(ExplainModel instance) =>
    <String, dynamic>{
      'author': instance.author,
      'groupVerse': instance.groupVerse,
      'content': instance.content,
    };
