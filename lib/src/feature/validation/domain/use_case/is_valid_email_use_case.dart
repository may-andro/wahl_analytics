import 'package:meta/meta.dart';
import 'package:use_case/use_case.dart';

sealed class IsValidEmailFailure extends BasicFailure {
  const IsValidEmailFailure({super.message, super.cause});
}

class InvalidEmailFailure extends IsValidEmailFailure {
  const InvalidEmailFailure({super.message, super.cause});
}

class EmptyEmailFailure extends IsValidEmailFailure {
  const EmptyEmailFailure();
}

class NullEmailFailure extends IsValidEmailFailure {
  const NullEmailFailure();
}

class IsValidEmailUseCase
    extends BaseUseCase<bool, String?, IsValidEmailFailure> {
  @protected
  @override
  Either<IsValidEmailFailure, bool> execute(String? input) {
    if (input == null) {
      return const Left(NullEmailFailure());
    }

    if (input.isEmpty) {
      return const Left(EmptyEmailFailure());
    }

    final regEx = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return Right(regEx.hasMatch(input));
  }

  @protected
  @override
  IsValidEmailFailure mapErrorToFailure(Object e, StackTrace st) {
    return InvalidEmailFailure(message: 'Invalid name', cause: e);
  }
}
