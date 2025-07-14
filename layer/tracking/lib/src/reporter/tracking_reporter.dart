import 'package:tracking/src/model/model.dart';

abstract interface class TrackingReporter {
  void sendTrackingEvent(Tracking tracking);

  Map<DateTime, Tracking>? get sentTrackingEvents;
}
