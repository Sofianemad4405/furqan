// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verse_tafsir.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerseTafsir _$VerseTafsirFromJson(Map<String, dynamic> json) => VerseTafsir(
  tafseerId: (json['tafseer_id'] as num).toInt(),
  tafseerName: json['tafseer_name'] as String,
  ayahUrl: json['ayah_url'] as String,
  ayahNumber: (json['ayah_number'] as num).toInt(),
  text: json['text'] as String,
);

Map<String, dynamic> _$VerseTafsirToJson(VerseTafsir instance) =>
    <String, dynamic>{
      'tafseer_id': instance.tafseerId,
      'tafseer_name': instance.tafseerName,
      'ayah_url': instance.ayahUrl,
      'ayah_number': instance.ayahNumber,
      'text': instance.text,
    };
