import 'dart:async';

import 'package:use_case/use_case.dart';
import 'package:wahl_analytics/src/feature/developer_option/domain/repository/repository.dart';

class RequestVerificationCodeFailure extends BasicFailure {
  const RequestVerificationCodeFailure({super.message, super.cause});
}

class RequestVerificationCodeUseCase
    extends BaseNoParamUseCase<String?, RequestVerificationCodeFailure> {
  RequestVerificationCodeUseCase(
    this._devModeAuthRepository,
  );

  final DevModeAuthRepository _devModeAuthRepository;

  @override
  FutureOr<Either<RequestVerificationCodeFailure, String?>> execute() async {
    final docId = await _devModeAuthRepository.requestVerificationCode();
    return Right(docId);
  }

  @override
  RequestVerificationCodeFailure mapErrorToFailure(Object e, StackTrace st) {
    return RequestVerificationCodeFailure(message: e.toString(), cause: st);
  }
}
