import 'package:meta/meta.dart';
import 'package:use_case/use_case.dart';

sealed class IsValidVerificationCodeFailure extends BasicFailure {
  const IsValidVerificationCodeFailure({super.message, super.cause});
}

class InvalidVerificationCodeFailure extends IsValidVerificationCodeFailure {
  const InvalidVerificationCodeFailure({super.message, super.cause});
}

class EmptyVerificationCodeFailure extends IsValidVerificationCodeFailure {
  const EmptyVerificationCodeFailure();
}

class NullVerificationCodeFailure extends IsValidVerificationCodeFailure {
  const NullVerificationCodeFailure();
}

class IsValidVerificationCodeUseCase
    extends BaseUseCase<bool, String?, IsValidVerificationCodeFailure> {
  @protected
  @override
  Either<IsValidVerificationCodeFailure, bool> execute(String? input) {
    if (input == null) {
      return const Left(NullVerificationCodeFailure());
    }

    if (input.isEmpty) {
      return const Left(EmptyVerificationCodeFailure());
    }

    final bool isValidVerificationCode = RegExp(r'^\d{6}$').hasMatch(input);
    return Right(isValidVerificationCode);
  }

  @protected
  @override
  IsValidVerificationCodeFailure mapErrorToFailure(Object e, StackTrace st) {
    return InvalidVerificationCodeFailure(
      message: 'Invalid Verification Code',
      cause: e,
    );
  }
}
