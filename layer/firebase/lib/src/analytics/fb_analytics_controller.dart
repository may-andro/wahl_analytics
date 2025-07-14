import 'package:firebase_analytics/firebase_analytics.dart';

class FbAnalyticsController {
  FbAnalyticsController(this._firebaseAnalytics);

  final FirebaseAnalytics _firebaseAnalytics;

  Future<void> enableFirebaseAnalytics(bool isEnabled) {
    return _firebaseAnalytics.setAnalyticsCollectionEnabled(isEnabled);
  }

  Future<void> sendUserEvent(
    String userId, {
    Map<String, String>? additionalProps,
  }) async {
    await _firebaseAnalytics.setUserId(id: userId);
    if (additionalProps != null && additionalProps.isNotEmpty) {
      additionalProps.forEach((key, value) {
        _firebaseAnalytics.setUserProperty(name: key, value: value);
      });
    }
  }

  Future<void> sendLogEvent(String event, {Map<String, Object>? parameters}) {
    return _firebaseAnalytics.logEvent(name: event, parameters: parameters);
  }
}
