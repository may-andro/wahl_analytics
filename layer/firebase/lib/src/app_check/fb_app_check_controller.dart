import 'package:firebase/src/app_check/token.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart';

class AppCheckException implements Exception {
  AppCheckException(this.cause, this.stackTrace);

  final Object cause;
  final StackTrace stackTrace;
}

class FbAppCheckController {
  FbAppCheckController(this._firebaseAppCheck);

  final FirebaseAppCheck _firebaseAppCheck;

  Future<void> initialiseAppCheck() async {
    try {
      await _firebaseAppCheck.activate(
        webProvider: ReCaptchaV3Provider(
          kDebugMode ? Token.debug : Token.release,
        ),
        androidProvider: kDebugMode
            ? AndroidProvider.debug
            : AndroidProvider.playIntegrity,
        appleProvider: kDebugMode
            ? AppleProvider.debug
            : AppleProvider.appAttest,
      );
      await _firebaseAppCheck.setTokenAutoRefreshEnabled(true);
    } catch (e, st) {
      throw AppCheckException(e.toString(), st);
    }
  }
}
