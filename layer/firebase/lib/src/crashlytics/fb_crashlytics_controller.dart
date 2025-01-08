import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class FbCrashlyticsController {
  FbCrashlyticsController(this._firebaseCrashlytics);

  final FirebaseCrashlytics _firebaseCrashlytics;

  bool get isCrashlyticsEnabled {
    if (!_isFeatureSupported) return false;
    return _firebaseCrashlytics.isCrashlyticsCollectionEnabled;
  }

  Future<void> setCrashlyticsEnabled(bool isEnabled) async {
    if (_isFeatureSupported) {
      return _firebaseCrashlytics.setCrashlyticsCollectionEnabled(isEnabled);
    }
  }

  Future<void> setUser(String userId) async {
    if (_isOperationAllowed) {
      return _firebaseCrashlytics.setUserIdentifier(userId);
    }
  }

  void forceCrash() {
    if (_isOperationAllowed) {
      return _firebaseCrashlytics.crash();
    }
  }

  Future<void> logMessage(String message) async {
    if (_isOperationAllowed) {
      return _firebaseCrashlytics.log(message);
    }
  }

  Future<void> reportError(
    Object error,
    StackTrace? stackTrace, {
    bool isFatal = false,
  }) async {
    if (_isOperationAllowed) {
      return _firebaseCrashlytics.recordError(
        error,
        stackTrace,
        fatal: isFatal,
      );
    }
  }

  Future<void> reportFlutterError(FlutterErrorDetails error) async {
    if (_isOperationAllowed) {
      return _firebaseCrashlytics.recordFlutterError(error);
    }
  }

  bool get _isOperationAllowed => _isFeatureSupported && isCrashlyticsEnabled;

  bool get _isFeatureSupported {
    if (kIsWeb) {
      return false;
    }

    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }
}
