import 'package:meta/meta.dart';
import 'package:use_case/use_case.dart';

sealed class IsValidRoleFailure extends BasicFailure {
  const IsValidRoleFailure({super.message, super.cause});
}

class InvalidRoleFailure extends IsValidRoleFailure {
  const InvalidRoleFailure({super.message, super.cause});
}

class EmptyRoleFailure extends IsValidRoleFailure {
  const EmptyRoleFailure();
}

class NullRoleFailure extends IsValidRoleFailure {
  const NullRoleFailure();
}

class IsValidRoleUseCase
    extends BaseUseCase<bool, String?, IsValidRoleFailure> {
  @protected
  @override
  Either<IsValidRoleFailure, bool> execute(String? input) {
    if (input == null) {
      return const Left(NullRoleFailure());
    }

    if (input.isEmpty) {
      return const Left(EmptyRoleFailure());
    }

    final bool isValidRole = RegExp(
      r"^(?!\s*$)[a-zA-Z\s'-]{1,40}$",
    ).hasMatch(input);
    return Right(isValidRole);
  }

  @protected
  @override
  IsValidRoleFailure mapErrorToFailure(Object e, StackTrace st) {
    return InvalidRoleFailure(message: 'Invalid Role', cause: e);
  }
}
