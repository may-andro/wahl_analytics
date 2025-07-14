import 'package:firebase/src/crashlytics/fb_crashlytics_controller.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseCrashlytics extends Mock implements FirebaseCrashlytics {
  void mockIsCrashlyticsCollectionEnabled(bool expected) {
    when(() => isCrashlyticsCollectionEnabled).thenReturn(expected);
  }

  void mockSetCrashlyticsCollectionEnabled() {
    when(() => setCrashlyticsCollectionEnabled(any())).thenAnswer((_) async {});
  }

  void mockSetUserIdentifier() {
    when(() => setUserIdentifier(any())).thenAnswer((_) async {});
  }

  void mockCrash() {
    when(crash).thenReturn(null);
  }

  void mockLog() {
    when(() => log(any())).thenAnswer((_) async {});
  }

  void mockRecordError(String error, StackTrace? st, bool isFatal) {
    when(
      () => recordError(error, st, fatal: isFatal),
    ).thenAnswer((invocation) async {});
  }

  void mockRecordFlutterError(FlutterErrorDetails error) {
    when(() => recordFlutterError(error)).thenAnswer((invocation) async {});
  }
}

void main() {
  group(FbCrashlyticsController, () {
    late FbCrashlyticsController fbCrashlyticsController;

    late MockFirebaseCrashlytics mockFirebaseCrashlytics;

    setUp(() {
      mockFirebaseCrashlytics = MockFirebaseCrashlytics();

      fbCrashlyticsController = FbCrashlyticsController(
        mockFirebaseCrashlytics,
      );
    });

    group('isCrashlyticsEnabled', () {
      test(
        'should return value from FirebaseCrashlytics when platform is supported',
        () {
          mockFirebaseCrashlytics.mockIsCrashlyticsCollectionEnabled(true);

          expect(fbCrashlyticsController.isCrashlyticsEnabled, isTrue);
        },
      );

      test('should return false when platform is not supported', () {
        debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

        expect(fbCrashlyticsController.isCrashlyticsEnabled, isFalse);

        debugDefaultTargetPlatformOverride = null;
      });
    });

    group('setCrashlyticsEnabled', () {
      test(
        'should not enable Crashlytics when platform is not supported',
        () async {
          debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

          await fbCrashlyticsController.setCrashlyticsEnabled(true);

          verifyNever(
            () =>
                mockFirebaseCrashlytics.setCrashlyticsCollectionEnabled(any()),
          );
          debugDefaultTargetPlatformOverride = null;
        },
      );

      test('should enable Crashlytics when platform is supported', () async {
        mockFirebaseCrashlytics.mockSetCrashlyticsCollectionEnabled();

        await fbCrashlyticsController.setCrashlyticsEnabled(true);

        verify(
          () => mockFirebaseCrashlytics.setCrashlyticsCollectionEnabled(true),
        ).called(1);
      });
    });

    group('setUser', () {
      setUp(() {
        mockFirebaseCrashlytics.mockSetUserIdentifier();
      });

      test('should set user identifier when operation is allowed', () async {
        mockFirebaseCrashlytics.mockIsCrashlyticsCollectionEnabled(true);

        await fbCrashlyticsController.setUser('user123');

        verify(
          () => mockFirebaseCrashlytics.setUserIdentifier('user123'),
        ).called(1);
      });

      test(
        'should not set user identifier when operation is not allowed',
        () async {
          mockFirebaseCrashlytics.mockIsCrashlyticsCollectionEnabled(false);

          await fbCrashlyticsController.setUser('user123');

          verifyNever(() => mockFirebaseCrashlytics.setUserIdentifier(any()));
        },
      );

      test(
        'should not set user identifier when platform is not supported',
        () async {
          debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
          mockFirebaseCrashlytics.mockIsCrashlyticsCollectionEnabled(true);

          await fbCrashlyticsController.setUser('user123');

          verifyNever(() => mockFirebaseCrashlytics.setUserIdentifier(any()));
          debugDefaultTargetPlatformOverride = null;
        },
      );
    });

    group('forceCrash', () {
      setUp(() {
        mockFirebaseCrashlytics.mockCrash();
      });

      test('should call crash when operation is allowed', () {
        mockFirebaseCrashlytics.mockIsCrashlyticsCollectionEnabled(true);

        fbCrashlyticsController.forceCrash();

        verify(() => mockFirebaseCrashlytics.crash()).called(1);
      });

      test('should not call crash when operation is not allowed', () {
        mockFirebaseCrashlytics.mockIsCrashlyticsCollectionEnabled(false);

        fbCrashlyticsController.forceCrash();

        verifyNever(() => mockFirebaseCrashlytics.crash());
      });

      test('should not call crash when platform is not supported', () {
        debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
        mockFirebaseCrashlytics.mockIsCrashlyticsCollectionEnabled(true);

        fbCrashlyticsController.forceCrash();

        verifyNever(() => mockFirebaseCrashlytics.crash());
        debugDefaultTargetPlatformOverride = null;
      });
    });

    group('logMessage', () {
      setUp(() {
        mockFirebaseCrashlytics.mockLog();
      });

      test('should log message when operation is allowed', () async {
        mockFirebaseCrashlytics.mockIsCrashlyticsCollectionEnabled(true);

        await fbCrashlyticsController.logMessage('Crash occurred');

        verify(() => mockFirebaseCrashlytics.log('Crash occurred')).called(1);
      });

      test('should not log message when operation is not allowed', () async {
        mockFirebaseCrashlytics.mockIsCrashlyticsCollectionEnabled(false);

        await fbCrashlyticsController.logMessage('Crash occurred');

        verifyNever(() => mockFirebaseCrashlytics.log(any()));
      });

      test('should not log message when platform is not supported', () async {
        debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
        mockFirebaseCrashlytics.mockIsCrashlyticsCollectionEnabled(true);

        await fbCrashlyticsController.logMessage('Crash occurred');

        verifyNever(() => mockFirebaseCrashlytics.log(any()));
        debugDefaultTargetPlatformOverride = null;
      });
    });

    group('reportError', () {
      const error = '';
      const StackTrace? st = null;
      const isFatal = true;

      setUp(() {
        mockFirebaseCrashlytics.mockRecordError(error, st, isFatal);
      });

      test('should record error if operation is allowed', () async {
        mockFirebaseCrashlytics.mockIsCrashlyticsCollectionEnabled(true);

        await fbCrashlyticsController.reportError(error, st, isFatal: true);

        verify(
          () => mockFirebaseCrashlytics.recordError(error, st, fatal: true),
        ).called(1);
      });

      test('should not record error if operation is not allowed', () async {
        mockFirebaseCrashlytics.mockIsCrashlyticsCollectionEnabled(false);

        await fbCrashlyticsController.reportError(error, st);

        verifyNever(
          () => mockFirebaseCrashlytics.recordError(any<dynamic>(), any()),
        );
      });
    });

    group('reportFlutterError', () {
      final errorDetails = FlutterErrorDetails(
        exception: Exception('Flutter error'),
      );

      setUp(() {
        mockFirebaseCrashlytics.mockRecordFlutterError(errorDetails);
      });

      test('should record Flutter error if operation is allowed', () async {
        mockFirebaseCrashlytics.mockIsCrashlyticsCollectionEnabled(true);

        await fbCrashlyticsController.reportFlutterError(errorDetails);

        verify(
          () => mockFirebaseCrashlytics.recordFlutterError(errorDetails),
        ).called(1);
      });

      test(
        'should not record Flutter error if operation is not allowed',
        () async {
          mockFirebaseCrashlytics.mockIsCrashlyticsCollectionEnabled(false);

          final errorDetails = FlutterErrorDetails(
            exception: Exception('Flutter error'),
          );
          await fbCrashlyticsController.reportFlutterError(errorDetails);

          verifyNever(
            () => mockFirebaseCrashlytics.recordFlutterError(errorDetails),
          );
        },
      );
    });
  });
}
