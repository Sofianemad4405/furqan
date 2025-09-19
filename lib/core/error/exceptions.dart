///server exception
class ServerException implements Exception {
  final String message;

  ServerException({required this.message});
}

///cashe exception

class CacheException implements Exception {
  final String message;

  CacheException({required this.message});
}
