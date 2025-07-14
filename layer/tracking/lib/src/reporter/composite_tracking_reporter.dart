import 'package:tracking/src/model/model.dart';
import 'package:tracking/src/reporter/tracking_reporter.dart';

class CompositeTrackingReporter implements TrackingReporter {
  CompositeTrackingReporter(this.reporters);

  final List<TrackingReporter> reporters;

  @override
  void sendTrackingEvent(Tracking tracking) {
    for (final reporter in reporters) {
      reporter.sendTrackingEvent(tracking);
    }
  }

  @override
  Map<DateTime, Tracking>? get sentTrackingEvents {
    final reporter = reporters
        .where((reporter) => reporter.sentTrackingEvents != null)
        .firstOrNull;
    return reporter?.sentTrackingEvents;
  }
}
