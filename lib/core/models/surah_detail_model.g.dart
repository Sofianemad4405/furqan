// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surah_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurahDetailModel _$SurahDetailModelFromJson(Map<String, dynamic> json) =>
    SurahDetailModel(
      surahName: json['surahName'] as String,
      surahNo: (json['surahNo'] as num).toInt(),
      ayahNo: (json['ayahNo'] as num).toInt(),
      tafsirs: (json['tafsirs'] as List<dynamic>)
          .map((e) => ExplainModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SurahDetailModelToJson(SurahDetailModel instance) =>
    <String, dynamic>{
      'surahName': instance.surahName,
      'surahNo': instance.surahNo,
      'ayahNo': instance.ayahNo,
      'tafsirs': instance.tafsirs,
    };
