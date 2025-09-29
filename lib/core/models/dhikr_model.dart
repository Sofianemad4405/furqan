import 'package:furqan/core/entities/dhikr_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dhikr_model.g.dart';

@JsonSerializable()
class DhikrModel {
  final String zekr;
  final int repeat;
  final String bless;

  DhikrModel({required this.zekr, required this.repeat, required this.bless});

  factory DhikrModel.fromJson(Map<String, dynamic> json) =>
      _$DhikrModelFromJson(json);

  Map<String, dynamic> toJson() => _$DhikrModelToJson(this);

  DhikrEntity toEntity() =>
      DhikrEntity(zekr: zekr, repeat: repeat, bless: bless);
}

// {
// "zekr": "أَعُوذُ بِاللهِ مِنْ الشَّيْطَانِ الرَّجِيمِ 'الله لا إلـه إلا هو الحي القيوم لا تأخذه سنة ولا نوم له ما في السماوات وما في الأرض من ذا الذي يشفع عنده إلا بإذنه يعلم ما بين أيديهم وما خلفهم ولا يحيطون بشيء من علمه إلا بما شاء وسع كرسيه السماوات والأرض ولا يؤوده حفظهما وهو العلي العظيم' -آية الكرسي,البقرة ,255.",
// "repeat": 1,
// "bless": "من قالها حين يصبح أجير من الجن حتى يمسى ومن قالها حين يمسى أجير من الجن حتى يصبح."
// },
