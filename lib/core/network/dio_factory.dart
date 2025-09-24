import 'package:dio/dio.dart';
import 'package:furqan/core/utils/constants.dart';

class DioFactory {
  Dio getDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        // headers: {"Content-Type": "application/json"},
      ),
    );

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return dio;
  }
}
