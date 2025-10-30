class TafsirProviderEntity {
  final int id;
  final String? name;
  final String? language;
  final String? author;
  final String? bookName;

  TafsirProviderEntity({
    required this.id,
    required this.name,
    required this.language,
    required this.author,
    required this.bookName,
  });
}
// {
// "id": 1,
// "name": "التفسير الميسر",
// "language": "ar",
// "author": "نخبة من العلماء",
// "book_name": "التفسير الميسر"
// },