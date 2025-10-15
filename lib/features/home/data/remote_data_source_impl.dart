import 'package:furqan/core/models/azkar_section.dart';
import 'package:furqan/core/network/adhkar_client.dart';
import 'package:furqan/features/home/data/abstract_remote_data_source.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  final AdhkarClient adhkarClient;
  RemoteDataSourceImpl(this.adhkarClient);
  @override
  Future<AzkarSection> getAdhkar(String category) async {
    try {
      final response = await adhkarClient.getAdhkar(category);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
