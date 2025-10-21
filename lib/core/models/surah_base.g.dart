// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surah_base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurahBase _$SurahBaseFromJson(Map<String, dynamic> json) => SurahBase(
      surahName: json['surahName'] as String,
      surahNameArabic: json['surahNameArabic'] as String,
      surahNameArabicLong: json['surahNameArabicLong'] as String,
      surahNameTranslation: json['surahNameTranslation'] as String,
      revelationPlace: json['revelationPlace'] as String,
      totalAyah: (json['totalAyah'] as num).toInt(),
    );

Map<String, dynamic> _$SurahBaseToJson(SurahBase instance) => <String, dynamic>{
      'surahName': instance.surahName,
      'surahNameArabic': instance.surahNameArabic,
      'surahNameArabicLong': instance.surahNameArabicLong,
      'surahNameTranslation': instance.surahNameTranslation,
      'revelationPlace': instance.revelationPlace,
      'totalAyah': instance.totalAyah,
    };
