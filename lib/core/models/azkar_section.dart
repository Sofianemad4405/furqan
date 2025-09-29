import 'package:furqan/core/entities/azkar_section_entity.dart';
import 'package:furqan/core/models/dhikr_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'azkar_section.g.dart';

@JsonSerializable()
class AzkarSection {
  final String title;
  final List<DhikrModel> content;
  AzkarSection({required this.title, required this.content});

  factory AzkarSection.fromJson(Map<String, dynamic> json) =>
      _$AzkarSectionFromJson(json);

  Map<String, dynamic> toJson() => _$AzkarSectionToJson(this);

  AzkarSectionEntity toEntity() {
    return AzkarSectionEntity(
      title: title,
      content: content.map((e) => e.toEntity()).toList(),
    );
  }
}
// {
// "title": "أذكار الصباح",
// "content": [
// {
// "zekr": "أَعُوذُ بِاللهِ مِنْ الشَّيْطَانِ الرَّجِيمِ 'الله لا إلـه إلا هو الحي القيوم لا تأخذه سنة ولا نوم له ما في السماوات وما في الأرض من ذا الذي يشفع عنده إلا بإذنه يعلم ما بين أيديهم وما خلفهم ولا يحيطون بشيء من علمه إلا بما شاء وسع كرسيه السماوات والأرض ولا يؤوده حفظهما وهو العلي العظيم' -آية الكرسي,البقرة ,255.",
// "repeat": 1,
// "bless": "من قالها حين يصبح أجير من الجن حتى يمسى ومن قالها حين يمسى أجير من الجن حتى يصبح."
// },