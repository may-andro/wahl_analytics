import 'package:tracking/tracking.dart';

class _TrackingArea extends TrackingArea {
  const _TrackingArea() : super('dev_mode');
}

class DevModeTrackingDelegate extends ScreenTrackingDelegate {
  DevModeTrackingDelegate(TrackingReporter trackingReporter)
    : super(const _TrackingArea(), trackingReporter);
}
