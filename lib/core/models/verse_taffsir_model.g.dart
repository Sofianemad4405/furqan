// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verse_taffsir_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerseTaffsirModel _$VerseTaffsirModelFromJson(Map<String, dynamic> json) =>
    VerseTaffsirModel(
      surahName: json['surahName'] as String,
      surahNo: (json['surahNo'] as num).toInt(),
      ayahNo: (json['ayahNo'] as num).toInt(),
      tafsirs: (json['tafsirs'] as List<dynamic>)
          .map((e) => ExplainModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VerseTaffsirModelToJson(VerseTaffsirModel instance) =>
    <String, dynamic>{
      'surahName': instance.surahName,
      'surahNo': instance.surahNo,
      'ayahNo': instance.ayahNo,
      'tafsirs': instance.tafsirs,
    };
