import 'package:furqan/core/entities/dhikr_entity.dart';

class AzkarSectionEntity {
  final String title;
  final List<DhikrEntity> content;

  AzkarSectionEntity({required this.title, required this.content});
}

// {
// "title": "أذكار الصباح",
// "content": [
// {
// "zekr": "أَعُوذُ بِاللهِ مِنْ الشَّيْطَانِ الرَّجِيمِ 'الله لا إلـه إلا هو الحي القيوم لا تأخذه سنة ولا نوم له ما في السماوات وما في الأرض من ذا الذي يشفع عنده إلا بإذنه يعلم ما بين أيديهم وما خلفهم ولا يحيطون بشيء من علمه إلا بما شاء وسع كرسيه السماوات والأرض ولا يؤوده حفظهما وهو العلي العظيم' -آية الكرسي,البقرة ,255.",
// "repeat": 1,
// "bless": "من قالها حين يصبح أجير من الجن حتى يمسى ومن قالها حين يمسى أجير من الجن حتى يصبح."
// },
