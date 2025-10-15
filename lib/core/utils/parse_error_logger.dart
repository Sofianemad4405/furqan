import 'dart:developer' as logger;

import 'package:dio/dio.dart';

/// A utility class for logging errors that occur during API calls.
class ParseErrorLogger {
  /// Logs an error that occurred during API response parsing.
  ///
  /// [error] - The error that occurred
  /// [stackTrace] - The stack trace of the error
  /// [options] - The request options for the failed request
  void logError(dynamic error, StackTrace stackTrace, RequestOptions options) {
    logger.log('API Error:');
    logger.log('URL: ${options.uri}');
    logger.log('Method: ${options.method}');
    logger.log('Error: $error');
    logger.log('Stack Trace: $stackTrace');
  }
}
