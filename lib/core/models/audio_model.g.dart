// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioModel _$AudioModelFromJson(Map<String, dynamic> json) => AudioModel(
  reciter: json['reciter']?.toString() ?? '',
  url: json['url']?.toString() ?? '',
  originalUrl: json['originalUrl']?.toString() ?? '',
);

Map<String, dynamic> _$AudioModelToJson(AudioModel instance) =>
    <String, dynamic>{
      'reciter': instance.reciter,
      'url': instance.url,
      'originalUrl': instance.originalUrl,
    };
