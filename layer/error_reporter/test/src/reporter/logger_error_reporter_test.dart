import 'package:error_reporter/src/exception/fatal_exception.dart';
import 'package:error_reporter/src/fatal_error/fatal_error_controller.dart';
import 'package:error_reporter/src/reporter/logger_error_reporter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:log_reporter/log_reporter.dart';
import 'package:mocktail/mocktail.dart';

class MockLogReporter extends Mock implements LogReporter {}

class MockFatalErrorController extends Mock implements FatalErrorController {
  void mockOnFatalError() {
    when(() => onFatalError(any())).thenAnswer((_) async {});
  }

  void mockIsFatalError(bool expected) {
    when(() => isFatalError(any())).thenReturn(expected);
  }
}

class FakedException extends Fake implements Exception {}

class FakedStackTrace extends Fake implements StackTrace {}

class TestFatalException implements FatalException {}

void main() {
  group(LoggerErrorReporter, () {
    late LoggerErrorReporter loggerErrorReporter;

    late MockFatalErrorController mockFatalErrorController;
    late MockLogReporter mockLogReporter;

    setUpAll(() {
      registerFallbackValue(FakedException());
      registerFallbackValue(FakedStackTrace());
    });

    setUp(() {
      mockFatalErrorController = MockFatalErrorController()..mockOnFatalError();
      mockLogReporter = MockLogReporter();

      loggerErrorReporter = LoggerErrorReporter(
        mockFatalErrorController,
        mockLogReporter,
      );
    });

    group('init', () {
      test('should register ${FlutterError.onError}', () async {
        mockFatalErrorController.mockIsFatalError(true);

        await loggerErrorReporter.init();

        expect(FlutterError.onError, isNotNull);
      });
    });

    group('reportError', () {
      test('should log error in $LogReporter ', () async {
        final exception = TestFatalException();
        final stackTrace = StackTrace.current;

        await loggerErrorReporter.reportError(
          exception: exception,
          stackTrace: stackTrace,
        );

        verify(
          () => mockLogReporter.error(
            'Error occurred due to $exception',
            error: exception,
            stacktrace: stackTrace,
          ),
        ).called(1);
      });
    });
  });
}
