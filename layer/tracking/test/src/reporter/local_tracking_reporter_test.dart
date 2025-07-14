import 'package:flutter_test/flutter_test.dart';
import 'package:tracking/src/model/model.dart';
import 'package:tracking/src/reporter/reporter.dart';

void main() {
  group(LocalTrackingReporter, () {
    late LocalTrackingReporter reporter;

    setUp(() {
      reporter = LocalTrackingReporter();
    });

    group('sendTrackingEvent', () {
      test('should store event when sent', () {
        final event = AppStartTracking();
        reporter.sendTrackingEvent(event);

        expect(reporter.sentTrackingEvents?.length, equals(1));
        expect(reporter.sentTrackingEvents?.values.first, equals(event));
      });
    });

    group('sentTrackingEvents', () {
      test('should has no sent events initially', () {
        expect(reporter.sentTrackingEvents, isEmpty);
      });

      test('should return all sent events', () {
        reporter.sendTrackingEvent(AppStartTracking());
        reporter.sendTrackingEvent(ScreenViewTracking(area: SplashArea()));

        expect(reporter.sentTrackingEvents?.length, equals(2));
      });
    });
  });
}
