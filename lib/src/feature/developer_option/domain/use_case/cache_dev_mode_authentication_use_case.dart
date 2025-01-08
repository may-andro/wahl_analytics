import 'dart:async';

import 'package:use_case/use_case.dart';
import 'package:wahl_analytics/src/feature/developer_option/domain/repository/repository.dart';

class CacheDevModeAuthenticationUseCase
    extends BaseUseCase<void, bool, NoFailure> {
  CacheDevModeAuthenticationUseCase(this._devModeAuthRepository);

  final DevModeAuthRepository _devModeAuthRepository;

  @override
  FutureOr<Either<NoFailure, void>> execute(bool input) {
    return Right(_devModeAuthRepository.cacheDevModeAuthentication(input));
  }

  @override
  NoFailure mapErrorToFailure(Object e, StackTrace st) {
    return NoFailure();
  }
}
