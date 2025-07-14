import 'package:tracking/tracking.dart';

class _TrackingArea extends TrackingArea {
  const _TrackingArea() : super('cache_playground');
}

class CachePlaygroundTrackingDelegate extends ScreenTrackingDelegate {
  CachePlaygroundTrackingDelegate(TrackingReporter trackingReporter)
    : super(const _TrackingArea(), trackingReporter);
}
