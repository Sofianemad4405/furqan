// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'azkar_section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AzkarSection _$AzkarSectionFromJson(Map<String, dynamic> json) => AzkarSection(
      title: json['title'] as String,
      content: (json['content'] as List<dynamic>)
          .map((e) => DhikrModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AzkarSectionToJson(AzkarSection instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
    };
