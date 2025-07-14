import 'package:meta/meta.dart';
import 'package:use_case/use_case.dart';

sealed class IsValidMessageFailure extends BasicFailure {
  const IsValidMessageFailure({super.message, super.cause});
}

class InvalidMessageFailure extends IsValidMessageFailure {
  const InvalidMessageFailure({super.message, super.cause});
}

class EmptyMessageFailure extends IsValidMessageFailure {
  const EmptyMessageFailure();
}

class NullMessageFailure extends IsValidMessageFailure {
  const NullMessageFailure();
}

class IsValidMessageUseCase
    extends BaseUseCase<bool, String?, IsValidMessageFailure> {
  @protected
  @override
  Either<IsValidMessageFailure, bool> execute(String? input) {
    if (input == null) {
      return const Left(NullMessageFailure());
    }

    if (input.isEmpty) {
      return const Left(EmptyMessageFailure());
    }

    final regEx = RegExp(r'^(?!\s*$).{10,500}$', dotAll: true);
    return Right(regEx.hasMatch(input));
  }

  @protected
  @override
  IsValidMessageFailure mapErrorToFailure(Object e, StackTrace st) {
    return InvalidMessageFailure(message: 'Invalid message', cause: e);
  }
}
