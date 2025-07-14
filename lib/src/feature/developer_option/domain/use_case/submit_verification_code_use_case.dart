import 'dart:async';

import 'package:use_case/use_case.dart';
import 'package:wahl_analytics/src/feature/developer_option/domain/repository/repository.dart';

sealed class SubmitVerificationCodeFailure extends BasicFailure {
  const SubmitVerificationCodeFailure({super.message, super.cause});
}

class ExpiredCodeFailure extends SubmitVerificationCodeFailure {
  const ExpiredCodeFailure();
}

class UnknownSubmissionFailure extends SubmitVerificationCodeFailure {
  const UnknownSubmissionFailure({super.message, super.cause});
}

class SubmitVerificationCodeParam {
  SubmitVerificationCodeParam({required this.docId, required this.code});

  final String docId;
  final String code;
}

class SubmitVerificationCodeUseCase
    extends
        BaseUseCase<
          bool,
          SubmitVerificationCodeParam,
          SubmitVerificationCodeFailure
        > {
  SubmitVerificationCodeUseCase(this._devModeAuthRepository);

  final DevModeAuthRepository _devModeAuthRepository;

  @override
  FutureOr<Either<SubmitVerificationCodeFailure, bool>> execute(
    SubmitVerificationCodeParam input,
  ) async {
    final authVerification = await _devModeAuthRepository.getVerificationCode(
      input.docId,
    );

    final createdAt = authVerification.createdAt.toUtc();
    final currentTime = DateTime.now().toUtc();
    final difference = currentTime.difference(createdAt);
    if (difference.inMinutes > authVerification.validityInMin) {
      return const Left(ExpiredCodeFailure());
    }

    return Right(authVerification.code == input.code);
  }

  @override
  SubmitVerificationCodeFailure mapErrorToFailure(Object e, StackTrace st) {
    return UnknownSubmissionFailure(message: e.toString(), cause: st);
  }
}
