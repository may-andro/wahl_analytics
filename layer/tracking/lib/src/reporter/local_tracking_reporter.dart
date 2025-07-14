import 'package:tracking/src/model/model.dart';
import 'package:tracking/src/reporter/tracking_reporter.dart';

class LocalTrackingReporter implements TrackingReporter {
  LocalTrackingReporter();

  final Map<DateTime, Tracking> _trackingMap = {};

  @override
  void sendTrackingEvent(Tracking tracking) {
    _trackingMap[DateTime.now()] = tracking;
  }

  @override
  Map<DateTime, Tracking>? get sentTrackingEvents =>
      Map.unmodifiable(_trackingMap);
}
