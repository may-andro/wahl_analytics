import 'package:error_reporter/src/blacklist_error/blacklist_error_controller.dart';
import 'package:error_reporter/src/fatal_error/fatal_error.dart';
import 'package:error_reporter/src/reporter/crashlytics_error_reporter.dart';
import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'logger_error_reporter_test.dart';

class MockFatalErrorController extends Mock implements FatalErrorController {
  void mockOnFatalError() {
    when(() => onFatalError(any())).thenAnswer((_) async {});
  }

  void mockIsFatalError(bool expected) {
    when(() => isFatalError(any())).thenReturn(expected);
  }
}

class MockBlacklistErrorController extends Mock
    implements BlacklistErrorController {
  void mockIsBlacklistedError(bool expected) {
    when(() => isBlacklistedError(any())).thenReturn(expected);
  }
}

class MockFbCrashlyticsController extends Mock
    implements FbCrashlyticsController {
  void mockReportError() {
    when(
      () => reportError(any(), any(), isFatal: any(named: 'isFatal')),
    ).thenAnswer((_) async => {});
  }

  void mockReportFlutterError() {
    when(() => reportFlutterError(any())).thenAnswer((_) async => {});
  }
}

class FakedException extends Fake implements Exception {}

class FakedStackTrace extends Fake implements StackTrace {}

void main() {
  group(CrashlyticsErrorReporter, () {
    late CrashlyticsErrorReporter crashlyticsErrorReporter;

    late MockBlacklistErrorController mockBlacklistErrorController;
    late MockFatalErrorController mockFatalErrorController;
    late MockFbCrashlyticsController mockFbCrashlyticsController;
    late MockLogReporter mockLogReporter;

    setUpAll(() {
      registerFallbackValue(const FlutterErrorDetails(exception: 'test'));
      registerFallbackValue(FakedException());
      registerFallbackValue(FakedStackTrace());
    });

    setUp(() {
      mockBlacklistErrorController = MockBlacklistErrorController();
      mockFatalErrorController = MockFatalErrorController()..mockOnFatalError();
      mockFbCrashlyticsController = MockFbCrashlyticsController()
        ..mockReportError()
        ..mockReportFlutterError();
      mockLogReporter = MockLogReporter();

      crashlyticsErrorReporter = CrashlyticsErrorReporter(
        mockBlacklistErrorController,
        mockFatalErrorController,
        mockFbCrashlyticsController,
        mockLogReporter,
      );
    });

    group('init', () {
      test('should register ${FlutterError.onError}', () async {
        mockFatalErrorController.mockIsFatalError(true);
        mockBlacklistErrorController.mockIsBlacklistedError(false);

        await crashlyticsErrorReporter.init();

        expect(FlutterError.onError, isNotNull);
      });
    });

    group('reportError', () {
      test('should report fatal error '
          'when the error is not blacklisted', () async {
        final exception = TestFatalException();
        final stackTrace = StackTrace.current;
        mockFatalErrorController.mockIsFatalError(true);
        mockBlacklistErrorController.mockIsBlacklistedError(false);

        await crashlyticsErrorReporter.reportError(
          exception: exception,
          stackTrace: stackTrace,
        );

        verify(
          () => mockFbCrashlyticsController.reportError(
            exception,
            stackTrace,
            isFatal: true,
          ),
        ).called(1);
      });

      test('should not report fatal error '
          'when the error is blacklisted', () async {
        final exception = TestFatalException();
        final stackTrace = StackTrace.current;
        mockFatalErrorController.mockIsFatalError(true);
        mockBlacklistErrorController.mockIsBlacklistedError(true);

        await crashlyticsErrorReporter.reportError(
          exception: exception,
          stackTrace: stackTrace,
        );

        verifyNever(
          () => mockFbCrashlyticsController.reportError(
            exception,
            stackTrace,
            isFatal: any(named: 'isFatal'),
          ),
        );
      });

      test('should call $FatalErrorHandler '
          'when the error is fatal', () async {
        final exception = TestFatalException();
        final stackTrace = StackTrace.current;
        mockFatalErrorController.mockIsFatalError(true);
        mockBlacklistErrorController.mockIsBlacklistedError(true);

        await crashlyticsErrorReporter.reportError(
          exception: exception,
          stackTrace: stackTrace,
        );

        verify(() => mockFatalErrorController.onFatalError(any())).called(1);

        mockBlacklistErrorController.mockIsBlacklistedError(true);

        await crashlyticsErrorReporter.reportError(
          exception: exception,
          stackTrace: stackTrace,
        );

        verify(() => mockFatalErrorController.onFatalError(any())).called(1);
      });

      test('should not report non fatal error '
          'when the error is blacklisted', () async {
        final exception = TestFatalException();
        final stackTrace = StackTrace.current;
        mockFatalErrorController.mockIsFatalError(false);
        mockBlacklistErrorController.mockIsBlacklistedError(true);

        await crashlyticsErrorReporter.reportError(
          exception: exception,
          stackTrace: stackTrace,
        );

        verifyNever(
          () => mockFbCrashlyticsController.reportError(
            exception,
            stackTrace,
            isFatal: any(named: 'isFatal'),
          ),
        );
      });

      test('should report non fatal error '
          'when the error is not blacklisted', () async {
        final exception = TestFatalException();
        final stackTrace = StackTrace.current;
        mockFatalErrorController.mockIsFatalError(false);
        mockBlacklistErrorController.mockIsBlacklistedError(false);

        await crashlyticsErrorReporter.reportError(
          exception: exception,
          stackTrace: stackTrace,
        );

        verify(
          () => mockFbCrashlyticsController.reportError(exception, stackTrace),
        ).called(1);
      });
    });
  });
}
