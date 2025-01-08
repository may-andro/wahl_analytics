import 'package:core/core.dart';
import 'package:wahl_analytics/src/feature/developer_option/data/model/model.dart';
import 'package:wahl_analytics/src/feature/developer_option/domain/domain.dart';

class AuthVerificationMapper
    implements Mapper<AuthVerificationModel, AuthVerificationEntity> {
  @override
  AuthVerificationEntity map(AuthVerificationModel from) {
    return AuthVerificationEntity(
      code: from.code,
      createdAt: from.createdAt,
      validityInMin: 15, // 15 min of validity
    );
  }
}
