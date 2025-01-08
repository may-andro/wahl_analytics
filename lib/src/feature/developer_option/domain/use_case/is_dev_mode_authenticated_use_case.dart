import 'dart:async';

import 'package:use_case/use_case.dart';
import 'package:wahl_analytics/src/feature/developer_option/domain/repository/repository.dart';

class IsDevModeAuthenticatedUseCase
    extends BaseNoParamUseCase<bool, NoFailure> {
  IsDevModeAuthenticatedUseCase(this._devModeAuthRepository);

  final DevModeAuthRepository _devModeAuthRepository;

  @override
  FutureOr<Either<NoFailure, bool>> execute() {
    return Right(_devModeAuthRepository.isDevModeAuthenticated());
  }

  @override
  NoFailure mapErrorToFailure(Object e, StackTrace st) {
    return NoFailure();
  }
}
