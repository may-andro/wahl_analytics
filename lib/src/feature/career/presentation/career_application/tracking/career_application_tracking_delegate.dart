import 'package:tracking/tracking.dart';

class _TrackingArea extends TrackingArea {
  const _TrackingArea() : super('career_application');
}

class CareerApplicationTrackingDelegate extends ScreenTrackingDelegate {
  CareerApplicationTrackingDelegate(TrackingReporter trackingReporter)
    : super(const _TrackingArea(), trackingReporter);

  void trackSubmitForm() {
    trackEvent(ClickTracking(label: 'form_submit', value: 'successful'));
  }

  void trackSubmitFormFailure() {
    trackEvent(ClickTracking(label: 'form_submit', value: 'failed'));
  }

  void trackAppBarCloseClick() {
    trackEvent(ClickTracking(label: 'close_icon', value: 'screen_closed'));
  }
}
