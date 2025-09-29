// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tafsir_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TafsirProvider _$TafsirProviderFromJson(Map<String, dynamic> json) =>
    TafsirProvider(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      language: json['language'] as String,
      author: json['author'] as String,
      bookName: json['book_name'] as String,
    );

Map<String, dynamic> _$TafsirProviderToJson(TafsirProvider instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'language': instance.language,
      'author': instance.author,
      'book_name': instance.bookName,
    };
