import 'package:tracking/tracking.dart';

class _TrackingArea extends TrackingArea {
  const _TrackingArea() : super('tracking_log');
}

class TrackingLogTrackingDelegate extends ScreenTrackingDelegate {
  TrackingLogTrackingDelegate(TrackingReporter trackingReporter)
    : super(const _TrackingArea(), trackingReporter);

  Map<DateTime, Tracking>? get sentTrackingEvents =>
      trackingReporter.sentTrackingEvents;
}
