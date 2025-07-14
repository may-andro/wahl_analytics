import 'package:error_reporter/src/exception/app_exception.dart';
import 'package:error_reporter/src/fatal_error/fatal_error.dart';
import 'package:error_reporter/src/reporter/error_reporter.dart';
import 'package:flutter/material.dart';
import 'package:log_reporter/log_reporter.dart';
import 'package:meta/meta.dart';

@internal
class LoggerErrorReporter implements ErrorReporter {
  LoggerErrorReporter(this._fatalErrorController, this._logReporter);

  final FatalErrorController _fatalErrorController;
  final LogReporter _logReporter;

  @override
  Future<void> init() async {
    FlutterError.onError = (FlutterErrorDetails details) => _onError(
      details.exception,
      details.stack ?? StackTrace.empty,
      flutterErrorDetails: details,
    );
  }

  @override
  Future<void> reportError<T extends AppException>({
    required T exception,
    required StackTrace stackTrace,
    String? tag,
  }) async {
    _logReporter.error(
      'Error occurred due to $exception',
      tag: tag,
      error: exception,
      stacktrace: stackTrace,
    );
  }

  @override
  void Function(Object error, StackTrace st) get globalErrorHandler => _onError;

  Future<void> _onError(
    Object error,
    StackTrace stackTrace, {
    FlutterErrorDetails? flutterErrorDetails,
  }) async {
    if (_fatalErrorController.isFatalError(error)) {
      await _handleFatalError(error, stackTrace);
      return;
    }

    await _handleNonFatalError(
      error,
      stackTrace,
      flutterErrorDetails: flutterErrorDetails,
    );
  }

  Future<void> _handleFatalError(Object error, StackTrace stackTrace) async {
    _logReporter.error('=============================================');
    _logReporter.error('Fatal error found!!! Stopping the app...');
    _logReporter.error('Exception: $error');
    _logReporter.error(stackTrace.toString());
    _logReporter.error('=============================================');
    await _fatalErrorController.onFatalError(error);
  }

  Future<void> _handleNonFatalError(
    Object error,
    StackTrace stackTrace, {
    FlutterErrorDetails? flutterErrorDetails,
  }) async {
    _logReporter.error('=============================================');
    _logReporter.error('Non fatal error found!!!');
    _logReporter.error('Exception: $error');
    _logReporter.error(stackTrace.toString());
    _logReporter.error('=============================================');
  }
}
