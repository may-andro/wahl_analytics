import 'package:meta/meta.dart';
import 'package:use_case/use_case.dart';

sealed class IsValidShortDescriptionFailure extends BasicFailure {
  const IsValidShortDescriptionFailure({super.message, super.cause});
}

class InvalidShortDescriptionFailure extends IsValidShortDescriptionFailure {
  const InvalidShortDescriptionFailure({super.message, super.cause});
}

class EmptyShortDescriptionFailure extends IsValidShortDescriptionFailure {
  const EmptyShortDescriptionFailure();
}

class NullShortDescriptionFailure extends IsValidShortDescriptionFailure {
  const NullShortDescriptionFailure();
}

class IsValidShortDescriptionUseCase
    extends BaseUseCase<bool, String?, IsValidShortDescriptionFailure> {
  @protected
  @override
  Either<IsValidShortDescriptionFailure, bool> execute(String? input) {
    if (input == null) {
      return const Left(NullShortDescriptionFailure());
    }

    if (input.isEmpty) {
      return const Left(EmptyShortDescriptionFailure());
    }

    final regEx = RegExp(r'^(?!\s*$).{40,100}$');
    return Right(regEx.hasMatch(input));
  }

  @protected
  @override
  IsValidShortDescriptionFailure mapErrorToFailure(Object e, StackTrace st) {
    return InvalidShortDescriptionFailure(message: 'Invalid message', cause: e);
  }
}
