abstract class ApiConsumer {
  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters});
  Future<dynamic> post(String path, {Map<String, dynamic>? data});
  Future<dynamic> put(String path, {Map<String, dynamic>? data});
  Future<dynamic> delete(String path, {Map<String, dynamic>? data});
}
