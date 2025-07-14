import 'package:firebase/firebase.dart';
import 'package:wahl_analytics/src/feature/developer_option/data/mapper/mapper.dart';
import 'package:wahl_analytics/src/feature/developer_option/data/model/model.dart';
import 'package:wahl_analytics/src/feature/developer_option/domain/domain.dart';

class DevModeAuthRepositoryImpl implements DevModeAuthRepository {
  const DevModeAuthRepositoryImpl(
    this._fbFirestoreController,
    this._fbFunctionController,
    this._devUserAuthenticatedCache,
    this._authVerificationMapper,
  );

  final FbFirestoreController _fbFirestoreController;
  final FbFunctionController _fbFunctionController;
  final DevUserAuthenticatedCache _devUserAuthenticatedCache;
  final AuthVerificationMapper _authVerificationMapper;

  @override
  Future<AuthVerificationEntity> getVerificationCode(String docId) async {
    try {
      final dataMap = await _fbFirestoreController.getDocumentFromCollection(
        'verification_codes',
        docId,
      );

      if (dataMap == null) {
        throw const FormatException();
      }

      return _authVerificationMapper.map(
        AuthVerificationModel.fromJson(dataMap),
      );
    } catch (e, st) {
      if (e is FirestoreException) {
        throw DevModeAuthServerException(e.cause, st);
      }

      if (e is TypeError) {
        throw InvalidDevModeAuthJsonException(e, st);
      }

      if (e is FormatException) {
        throw NullDevModeAuthDataException(e, st);
      }

      throw UnknownDevModeAuthException(e, st);
    }
  }

  @override
  Future<String> requestVerificationCode() async {
    try {
      final dataMap =
          await _fbFunctionController.callFunction('sendDevMenuAuthEmail')
              as Map<String, dynamic>?;

      if (dataMap == null) {
        throw const FormatException();
      }

      final docId = dataMap['docId'] as String?;

      if (docId == null || docId.isEmpty) {
        throw const FormatException();
      }

      return docId;
    } catch (e, st) {
      if (e is FbFunctionException) {
        throw DevModeAuthServerException(e.cause, st);
      }

      if (e is TypeError) {
        throw InvalidDevModeAuthJsonException(e, st);
      }

      if (e is FormatException) {
        throw NullDevModeAuthDataException(e, st);
      }

      throw UnknownDevModeAuthException(e, st);
    }
  }

  @override
  void cacheDevModeAuthentication(bool isAuthenticated) {
    _devUserAuthenticatedCache.put(isAuthenticated);
  }

  @override
  bool isDevModeAuthenticated() {
    return _devUserAuthenticatedCache.get() ?? false;
  }
}
