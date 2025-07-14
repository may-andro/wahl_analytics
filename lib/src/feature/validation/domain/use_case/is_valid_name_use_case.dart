import 'package:meta/meta.dart';
import 'package:use_case/use_case.dart';

sealed class IsValidNameFailure extends BasicFailure {
  const IsValidNameFailure({super.message, super.cause});
}

class InvalidNameFailure extends IsValidNameFailure {
  const InvalidNameFailure({super.message, super.cause});
}

class EmptyNameFailure extends IsValidNameFailure {
  const EmptyNameFailure();
}

class NullNameFailure extends IsValidNameFailure {
  const NullNameFailure();
}

class IsValidNameUseCase
    extends BaseUseCase<bool, String?, IsValidNameFailure> {
  @protected
  @override
  Either<IsValidNameFailure, bool> execute(String? input) {
    if (input == null) {
      return const Left(NullNameFailure());
    }

    if (input.isEmpty) {
      return const Left(EmptyNameFailure());
    }

    final bool isValidName = RegExp(
      r"^(?!\s*$)[a-zA-Z\s'-]{1,50}$",
    ).hasMatch(input);
    return Right(isValidName);
  }

  @protected
  @override
  IsValidNameFailure mapErrorToFailure(Object e, StackTrace st) {
    return InvalidNameFailure(message: 'Invalid name', cause: e);
  }
}
