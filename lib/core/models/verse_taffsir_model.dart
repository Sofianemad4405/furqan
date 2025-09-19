import 'package:furqan/core/models/explain_model.dart';

class VerseTaffsirModel {
  final String surahName;
  final int surahNo;
  final int ayahNo;
  final List<ExplainModel> tafsirs;

  VerseTaffsirModel({
    required this.surahName,
    required this.surahNo,
    required this.ayahNo,
    required this.tafsirs,
  });
}
