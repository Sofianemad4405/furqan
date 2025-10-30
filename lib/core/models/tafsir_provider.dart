import 'package:furqan/features/reading/domain/entities/tafsir_provider_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tafsir_provider.g.dart';

@JsonSerializable()
class TafsirProvider {
  final int id;
  final String? name;
  final String? author;
  final String? bookName;
  final String? language;

  TafsirProvider({
    required this.id,
    this.name,
    this.author,
    this.bookName,
    this.language,
  });

  factory TafsirProvider.fromJson(Map<String, dynamic> json) {
    return _$TafsirProviderFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TafsirProviderToJson(this);
  }

  TafsirProviderEntity toEntity() {
    return TafsirProviderEntity(
      id: id,
      name: name,
      language: language,
      author: author,
      bookName: bookName,
    );
  }
}

// {
// "id": 1,
// "name": "التفسير الميسر",
// "language": "ar",
// "author": "نخبة من العلماء",
// "book_name": "التفسير الميسر"
// },
