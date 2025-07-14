import 'package:tracking/tracking.dart';

class _TrackingArea extends TrackingArea {
  const _TrackingArea() : super('feature_flag');
}

class FeatureFlagTrackingDelegate extends ScreenTrackingDelegate {
  FeatureFlagTrackingDelegate(TrackingReporter trackingReporter)
    : super(const _TrackingArea(), trackingReporter);
}
