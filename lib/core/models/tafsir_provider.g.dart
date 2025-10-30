// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tafsir_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TafsirProvider _$TafsirProviderFromJson(Map<String, dynamic> json) =>
    TafsirProvider(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      author: json['author'] as String?,
      bookName: json['bookName'] as String?,
      language: json['language'] as String?,
    );

Map<String, dynamic> _$TafsirProviderToJson(TafsirProvider instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'author': instance.author,
      'bookName': instance.bookName,
      'language': instance.language,
    };
