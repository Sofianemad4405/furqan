import 'package:json_annotation/json_annotation.dart';

part 'tafsir_provider.g.dart';

@JsonSerializable()
class TafsirProvider {
  final int id;
  final String name;
  final String language;
  final String author;
  final String bookName;

  TafsirProvider({
    required this.id,
    required this.name,
    required this.language,
    required this.author,
    required this.bookName,
  });

  factory TafsirProvider.fromJson(Map<String, dynamic> json) =>
      _$TafsirProviderFromJson(json);
  Map<String, dynamic> toJson() => _$TafsirProviderToJson(this);
}

// {
// "id": 1,
// "name": "التفسير الميسر",
// "language": "ar",
// "author": "نخبة من العلماء",
// "book_name": "التفسير الميسر"
// },
