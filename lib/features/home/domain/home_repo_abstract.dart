import 'package:furqan/core/entities/azkar_section_entity.dart';

abstract class HomeRepoAbstract {
  Future<AzkarSectionEntity> getAdhkar(String category);
}
