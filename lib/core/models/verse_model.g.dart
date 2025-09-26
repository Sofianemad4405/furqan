// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verse_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerseModel _$VerseModelFromJson(Map<String, dynamic> json) => VerseModel(
      surahName: json['surahName'] as String,
      surahNameArabic: json['surahNameArabic'] as String,
      surahNameArabicLong: json['surahNameArabicLong'] as String,
      surahNameTranslation: json['surahNameTranslation'] as String,
      revelationPlace: json['revelationPlace'] as String,
      verseEnglish: json['verseEnglish'] as String,
      verseArabic1: json['verseArabic1'] as String,
      verseArabic2: json['verseArabic2'] as String,
      totalAyah: (json['totalAyah'] as num).toInt(),
      ayahNo: (json['ayahNo'] as num).toInt(),
      surahNo: (json['surahNo'] as num).toInt(),
      verseAudio: (json['verseAudio'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, AudioModel.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$VerseModelToJson(VerseModel instance) =>
    <String, dynamic>{
      'surahName': instance.surahName,
      'surahNameArabic': instance.surahNameArabic,
      'surahNameArabicLong': instance.surahNameArabicLong,
      'surahNameTranslation': instance.surahNameTranslation,
      'revelationPlace': instance.revelationPlace,
      'verseEnglish': instance.verseEnglish,
      'verseArabic1': instance.verseArabic1,
      'verseArabic2': instance.verseArabic2,
      'totalAyah': instance.totalAyah,
      'ayahNo': instance.ayahNo,
      'surahNo': instance.surahNo,
      'verseAudio': instance.verseAudio,
    };
