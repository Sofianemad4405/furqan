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
  surahNo: (json['surahNo'] as num).toInt(),
  surahAudio: (json['surahAudio'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, AudioModel.fromJson(e as Map<String, dynamic>)),
  ),
  verseAudio: (json['verseAudio'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, AudioModel.fromJson(e as Map<String, dynamic>)),
  ),
  translation: (json['translation'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
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
      'surahAudio': instance.surahAudio,
      'verseAudio': instance.verseAudio,
      'translation': instance.translation,
    };
