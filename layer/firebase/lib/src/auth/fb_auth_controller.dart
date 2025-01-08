import 'package:firebase_auth/firebase_auth.dart';

class AuthException implements Exception {
  AuthException(this.cause, this.stackTrace);

  final Object cause;
  final StackTrace stackTrace;
}

class FbAuthController {
  FbAuthController(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  Future<String> signInAndGetAnonymousUser() async {
    try {
      final userCredential = await _firebaseAuth.signInAnonymously();
      final user = userCredential.user;

      if (user == null) {
        throw AuthException('User creation failed', StackTrace.current);
      }

      return user.uid;
    } catch (e, st) {
      throw AuthException(e, st);
    }
  }
}
