// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surah_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurahModel _$SurahModelFromJson(Map<String, dynamic> json) => SurahModel(
      surahName: json['surahName'] as String,
      surahNameArabic: json['surahNameArabic'] as String,
      surahNameArabicLong: json['surahNameArabicLong'] as String,
      surahNameTranslation: json['surahNameTranslation'] as String,
      revelationPlace: json['revelationPlace'] as String,
      totalAyah: (json['totalAyah'] as num).toInt(),
      audio: (json['audio'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, AudioModel.fromJson(e as Map<String, dynamic>)),
      ),
      english:
          (json['english'] as List<dynamic>?)?.map((e) => e as String).toList(),
      arabic1:
          (json['arabic1'] as List<dynamic>?)?.map((e) => e as String).toList(),
      arabic2:
          (json['arabic2'] as List<dynamic>?)?.map((e) => e as String).toList(),
      bengali:
          (json['bengali'] as List<dynamic>?)?.map((e) => e as String).toList(),
      urdu: (json['urdu'] as List<dynamic>?)?.map((e) => e as String).toList(),
      turkish:
          (json['turkish'] as List<dynamic>?)?.map((e) => e as String).toList(),
      uzbek:
          (json['uzbek'] as List<dynamic>?)?.map((e) => e as String).toList(),
      surahNo: (json['surahNo'] as num).toInt(),
    );

Map<String, dynamic> _$SurahModelToJson(SurahModel instance) =>
    <String, dynamic>{
      'surahName': instance.surahName,
      'surahNameArabic': instance.surahNameArabic,
      'surahNameArabicLong': instance.surahNameArabicLong,
      'surahNameTranslation': instance.surahNameTranslation,
      'revelationPlace': instance.revelationPlace,
      'totalAyah': instance.totalAyah,
      'surahNo': instance.surahNo,
      'audio': instance.audio,
      'english': instance.english,
      'arabic1': instance.arabic1,
      'arabic2': instance.arabic2,
      'bengali': instance.bengali,
      'urdu': instance.urdu,
      'turkish': instance.turkish,
      'uzbek': instance.uzbek,
    };
