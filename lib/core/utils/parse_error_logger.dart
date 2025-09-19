import 'package:dio/dio.dart';

/// A utility class for logging errors that occur during API calls.
class ParseErrorLogger {
  /// Logs an error that occurred during API response parsing.
  /// 
  /// [error] - The error that occurred
  /// [stackTrace] - The stack trace of the error
  /// [options] - The request options for the failed request
  void logError(
    dynamic error,
    StackTrace stackTrace,
    RequestOptions options,
  ) {
    // TODO: Implement proper error logging (e.g., Firebase Crashlytics, Sentry, etc.)
    print('API Error:');
    print('URL: ${options.uri}');
    print('Method: ${options.method}');
    print('Error: $error');
    print('Stack Trace: $stackTrace');
  }
}
