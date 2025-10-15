import 'package:furqan/core/models/azkar_section.dart';

abstract class RemoteDataSource {
  Future<AzkarSection> getAdhkar(String category);
}
