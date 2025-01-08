import 'package:wahl_analytics/src/feature/developer_option/domain/entity/entity.dart';

abstract class DevModeAuthRepository {
  Future<AuthVerificationEntity> getVerificationCode(String docId);

  Future<String> requestVerificationCode();

  void cacheDevModeAuthentication(bool isAuthenticated);

  bool isDevModeAuthenticated();
}
