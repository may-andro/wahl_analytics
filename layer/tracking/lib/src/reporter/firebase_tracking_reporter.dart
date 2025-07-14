import 'package:firebase/firebase.dart';
import 'package:tracking/src/model/model.dart';
import 'package:tracking/src/reporter/tracking_reporter.dart';

class FirebaseTrackingReporter implements TrackingReporter {
  FirebaseTrackingReporter(this.fbAnalyticsController);

  final FbAnalyticsController fbAnalyticsController;

  @override
  void sendTrackingEvent(Tracking tracking) {
    fbAnalyticsController.sendLogEvent(
      tracking.name,
      parameters: tracking.parameters,
    );
  }

  @override
  Map<DateTime, Tracking>? get sentTrackingEvents => null;
}
