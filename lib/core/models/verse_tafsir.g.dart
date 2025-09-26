// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verse_tafsir.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerseTafsir _$VerseTafsirFromJson(Map<String, dynamic> json) => VerseTafsir(
      tafseerId: (json['tafseerId'] as num).toInt(),
      tafseerName: json['tafseerName'] as String,
      ayahUrl: json['ayahUrl'] as String,
      ayahNumber: (json['ayahNumber'] as num).toInt(),
      text: json['text'] as String,
    );

Map<String, dynamic> _$VerseTafsirToJson(VerseTafsir instance) =>
    <String, dynamic>{
      'tafseerId': instance.tafseerId,
      'tafseerName': instance.tafseerName,
      'ayahUrl': instance.ayahUrl,
      'ayahNumber': instance.ayahNumber,
      'text': instance.text,
    };
