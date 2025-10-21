// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dhikr_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DhikrModel _$DhikrModelFromJson(Map<String, dynamic> json) => DhikrModel(
      zekr: json['zekr'] as String,
      repeat: (json['repeat'] as num).toInt(),
      bless: json['bless'] as String,
    );

Map<String, dynamic> _$DhikrModelToJson(DhikrModel instance) =>
    <String, dynamic>{
      'zekr': instance.zekr,
      'repeat': instance.repeat,
      'bless': instance.bless,
    };
