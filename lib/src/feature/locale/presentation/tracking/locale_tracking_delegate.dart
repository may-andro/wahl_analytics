import 'package:core/core.dart';
import 'package:tracking/tracking.dart';

class LocaleTrackingDelegate extends TrackingDelegate {
  LocaleTrackingDelegate(super.trackingReporter);

  void trackLocaleClick(AppLocale locale) {
    trackEvent(
      ClickTracking(label: 'selected_locale', value: locale.languageCode),
    );
  }

  void trackLocalePopupView() {
    trackEvent(ViewTracking(label: 'locale_popup'));
  }

  void trackUpdateLocaleClick(AppLocale locale) {
    trackEvent(
      ClickTracking(label: 'update_locale', value: locale.languageCode),
    );
  }
}
