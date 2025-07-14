import 'package:error_reporter/src/blacklist_error/blacklist_error.dart';
import 'package:error_reporter/src/exception/app_exception.dart';
import 'package:error_reporter/src/fatal_error/fatal_error.dart';
import 'package:error_reporter/src/reporter/error_reporter.dart';
import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:log_reporter/log_reporter.dart';
import 'package:meta/meta.dart';

@internal
class CrashlyticsErrorReporter implements ErrorReporter {
  CrashlyticsErrorReporter(
    this._blacklistErrorController,
    this._fatalErrorController,
    this._fbCrashlyticsController,
    this._logReporter,
  );

  final BlacklistErrorController _blacklistErrorController;
  final FatalErrorController _fatalErrorController;
  final FbCrashlyticsController _fbCrashlyticsController;
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
    await _onError(exception, stackTrace);
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
    if (!_blacklistErrorController.isBlacklistedError(error)) {
      await _fbCrashlyticsController.reportError(
        error,
        stackTrace,
        isFatal: true,
      );
    }

    await _fatalErrorController.onFatalError(error);
  }

  Future<void> _handleNonFatalError(
    Object error,
    StackTrace stackTrace, {
    FlutterErrorDetails? flutterErrorDetails,
  }) async {
    if (_blacklistErrorController.isBlacklistedError(error)) return;

    if (flutterErrorDetails != null) {
      await _fbCrashlyticsController.reportFlutterError(flutterErrorDetails);
    } else {
      await _fbCrashlyticsController.reportError(error, stackTrace);
    }
  }
}
