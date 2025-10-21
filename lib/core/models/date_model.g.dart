// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DateModel _$DateModelFromJson(Map<String, dynamic> json) => DateModel(
  readable: json['readable'] as String,
  timestamp: json['timestamp'] as String,
  weekDay: Map<String, String>.from(json['weekday'] as Map),
);

Map<String, dynamic> _$DateModelToJson(DateModel instance) => <String, dynamic>{
  'readable': instance.readable,
  'timestamp': instance.timestamp,
  'weekday': instance.weekDay,
};
