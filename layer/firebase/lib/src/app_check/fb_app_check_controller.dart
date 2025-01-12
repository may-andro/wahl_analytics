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
      const token = kDebugMode ? Token.debug : Token.release;
      print('FbAppCheckController.initialiseAppCheck kDebugMode: $kDebugMode isProd: ${token == Token.release} ${Token.release[0]}');
      await _firebaseAppCheck.activate(
        webProvider:
            ReCaptchaV3Provider(token),
        androidProvider:
            kDebugMode ? AndroidProvider.debug : AndroidProvider.playIntegrity,
        appleProvider:
            kDebugMode ? AppleProvider.debug : AppleProvider.appAttest,
      );
      await _firebaseAppCheck.setTokenAutoRefreshEnabled(true);
    } catch (e, st) {
      throw AppCheckException(e.toString(), st);
    }
  }
}
