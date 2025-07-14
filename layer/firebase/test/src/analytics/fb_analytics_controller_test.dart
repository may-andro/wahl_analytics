import 'package:firebase/src/analytics/fb_analytics_controller.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAnalytics extends Mock implements FirebaseAnalytics {
  void mockSetAnalyticsCollectionEnabled() {
    when(() => setAnalyticsCollectionEnabled(any())).thenAnswer((_) async {});
  }

  void mockSetUserId() {
    when(() => setUserId(id: any(named: 'id'))).thenAnswer((_) async {});
  }

  void mockSetUserProperty() {
    when(
      () => setUserProperty(
        name: any(named: 'name'),
        value: any(named: 'value'),
      ),
    ).thenAnswer((_) async {});
  }

  void mockLogEvent() {
    when(
      () => logEvent(
        name: any(named: 'name'),
        parameters: any(named: 'parameters'),
      ),
    ).thenAnswer((_) async {});
  }
}

void main() {
  group(FbAnalyticsController, () {
    late FbAnalyticsController fbAnalyticsController;

    late MockFirebaseAnalytics mockFirebaseAnalytics;

    setUp(() {
      mockFirebaseAnalytics = MockFirebaseAnalytics();

      fbAnalyticsController = FbAnalyticsController(mockFirebaseAnalytics);
    });

    group('enableFirebaseAnalytics', () {
      test('should call firebase analytics to enable/disabled when called', () {
        mockFirebaseAnalytics.mockSetAnalyticsCollectionEnabled();

        fbAnalyticsController.enableFirebaseAnalytics(true);

        verify(
          () => mockFirebaseAnalytics.setAnalyticsCollectionEnabled(true),
        ).called(1);

        fbAnalyticsController.enableFirebaseAnalytics(false);

        verify(
          () => mockFirebaseAnalytics.setAnalyticsCollectionEnabled(false),
        ).called(1);
      });
    });

    group('sendUserEvent', () {
      test('should send event to firebase analytics', () async {
        mockFirebaseAnalytics.mockSetUserId();
        mockFirebaseAnalytics.mockSetUserProperty();

        await fbAnalyticsController.sendUserEvent(
          'test',
          additionalProps: {'key': 'value'},
        );

        verify(() => mockFirebaseAnalytics.setUserId(id: 'test')).called(1);
        verify(
          () => mockFirebaseAnalytics.setUserProperty(
            name: 'key',
            value: 'value',
          ),
        ).called(1);
      });
    });

    group('sendLogEvent', () {
      test('should send event to firebase analytics', () {
        mockFirebaseAnalytics.mockLogEvent();

        fbAnalyticsController.sendLogEvent(
          'test',
          parameters: {'key': 'value'},
        );

        verify(
          () => mockFirebaseAnalytics.logEvent(
            name: 'test',
            parameters: {'key': 'value'},
          ),
        ).called(1);
      });
    });
  });
}
