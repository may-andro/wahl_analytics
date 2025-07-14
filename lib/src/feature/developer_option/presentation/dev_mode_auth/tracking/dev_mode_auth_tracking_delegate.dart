import 'package:tracking/tracking.dart';

class _TrackingArea extends TrackingArea {
  const _TrackingArea() : super('dev_mode_auth');
}

class DevModeAuthTrackingDelegate extends ScreenTrackingDelegate {
  DevModeAuthTrackingDelegate(_TrackingArea super.area, super.trackingReporter);
}
