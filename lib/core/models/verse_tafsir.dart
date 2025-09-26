import 'package:furqan/core/entities/tafsir_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verse_tafsir.g.dart';

@JsonSerializable()
class VerseTafsir {
  final int tafseerId;
  final String tafseerName;
  final String ayahUrl;
  final int ayahNumber;
  final String text;

  VerseTafsir({
    required this.tafseerId,
    required this.tafseerName,
    required this.ayahUrl,
    required this.ayahNumber,
    required this.text,
  });

  factory VerseTafsir.fromJson(Map<String, dynamic> json) =>
      _$VerseTafsirFromJson(json);
  Map<String, dynamic> toJson() => _$VerseTafsirToJson(this);
  VerseTafsirEntity toEntity() {
    return VerseTafsirEntity(
      tafseerId: tafseerId,
      tafseerName: tafseerName,
      ayahUrl: ayahUrl,
      ayahNumber: ayahNumber,
      text: text,
    );
  }
}

// {
// "tafseer_id": 1,
// "tafseer_name": "التفسير الميسر",
// "ayah_url": "/quran/1/1/",
// "ayah_number": 1,
// "text": "سورة الفاتحة سميت هذه السورة بالفاتحة؛ لأنه يفتتح بها القرآن العظيم، وتسمى المثاني؛ لأنها تقرأ في كل ركعة، ولها أسماء أخر. أبتدئ قراءة القرآن باسم الله مستعينا به، (اللهِ) علم على الرب -تبارك وتعالى- المعبود بحق دون سواه، وهو أخص أسماء الله تعالى، ولا يسمى به غيره سبحانه. (الرَّحْمَنِ) ذي الرحمة العامة الذي وسعت رحمته جميع الخلق، (الرَّحِيمِ) بالمؤمنين، وهما اسمان من أسمائه تعالى، يتضمنان إثبات صفة الرحمة لله تعالى كما يليق بجلاله."
// },
