import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tracking/src/model/model.dart';
import 'package:tracking/src/reporter/reporter.dart';

import '../../_mock/src/reporter/mock_tracking_reporter.dart';

void main() {
  group(CompositeTrackingReporter, () {
    late CompositeTrackingReporter reporter;
    late MockTrackingReporter mockTrackingReporter1;
    late MockTrackingReporter mockTrackingReporter2;

    setUp(() {
      mockTrackingReporter1 = MockTrackingReporter();
      mockTrackingReporter2 = MockTrackingReporter();
      reporter = CompositeTrackingReporter([
        mockTrackingReporter1,
        mockTrackingReporter2,
      ]);
    });

    group('sendTrackingEvent', () {
      test('should delegates Tracking to all reporters', () {
        final tracking = AppStartTracking();

        when(
          () => mockTrackingReporter1.sendTrackingEvent(tracking),
        ).thenReturn(null);
        when(
          () => mockTrackingReporter2.sendTrackingEvent(tracking),
        ).thenReturn(null);

        reporter.sendTrackingEvent(tracking);

        verify(
          () => mockTrackingReporter1.sendTrackingEvent(tracking),
        ).called(1);
        verify(
          () => mockTrackingReporter2.sendTrackingEvent(tracking),
        ).called(1);
      });
    });

    group('sentTrackingEvents', () {
      test(
        'should return tracking events from first reporter with non-null stored values',
        () {
          final tracking = AppStartTracking();
          final trackingMap = {DateTime.now(): tracking};
          when(() => mockTrackingReporter1.sentTrackingEvents).thenReturn(null);
          when(
            () => mockTrackingReporter2.sentTrackingEvents,
          ).thenReturn(trackingMap);

          expect(reporter.sentTrackingEvents, equals(trackingMap));
        },
      );

      test('should return null if no reporter has stored tracking events', () {
        when(() => mockTrackingReporter1.sentTrackingEvents).thenReturn(null);
        when(() => mockTrackingReporter2.sentTrackingEvents).thenReturn(null);

        expect(reporter.sentTrackingEvents, isNull);
      });
    });
  });
}
