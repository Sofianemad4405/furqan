// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioModel _$AudioModelFromJson(Map<String, dynamic> json) => AudioModel(
  recieter: json['recieter'] as String,
  url: json['url'] as String,
  originalUrl: json['originalUrl'] as String,
);

Map<String, dynamic> _$AudioModelToJson(AudioModel instance) =>
    <String, dynamic>{
      'recieter': instance.recieter,
      'url': instance.url,
      'originalUrl': instance.originalUrl,
    };
