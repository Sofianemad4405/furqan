import 'package:furqan/core/entities/azkar_section_entity.dart';
import 'package:furqan/features/home/data/abstract_remote_data_source.dart';
import 'package:furqan/features/home/domain/home_repo_abstract.dart';

class HomeRepoImpl implements HomeRepoAbstract {
  final RemoteDataSource remoteDataSource;
  HomeRepoImpl(this.remoteDataSource);
  @override
  Future<AzkarSectionEntity> getAdhkar(String category) async {
    try {
      final response = await remoteDataSource.getAdhkar(category);
      return response.toEntity();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
