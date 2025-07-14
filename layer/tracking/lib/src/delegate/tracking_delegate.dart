import 'package:tracking/src/model/model.dart';
import 'package:tracking/src/reporter/reporter.dart';

abstract class TrackingDelegate {
  const TrackingDelegate(this.trackingReporter);

  final TrackingReporter trackingReporter;

  void trackEvent(Tracking tracking) {
    trackingReporter.sendTrackingEvent(tracking);
  }
}

abstract class ScreenTrackingDelegate extends TrackingDelegate {
  ScreenTrackingDelegate(TrackingArea area, TrackingReporter trackingReporter)
    : super(trackingReporter) {
    _area = area;
  }

  late final TrackingArea _area;

  void trackScreenView() {
    trackEvent(ScreenViewTracking(area: _area));
  }
}
