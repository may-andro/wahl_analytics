import 'package:meta/meta.dart';
import 'package:use_case/use_case.dart';

sealed class IsValidLongDescriptionFailure extends BasicFailure {
  const IsValidLongDescriptionFailure({super.message, super.cause});
}

class InvalidLongDescriptionFailure extends IsValidLongDescriptionFailure {
  const InvalidLongDescriptionFailure({super.message, super.cause});
}

class EmptyLongDescriptionFailure extends IsValidLongDescriptionFailure {
  const EmptyLongDescriptionFailure();
}

class NullLongDescriptionFailure extends IsValidLongDescriptionFailure {
  const NullLongDescriptionFailure();
}

class IsValidLongDescriptionUseCase
    extends BaseUseCase<bool, String?, IsValidLongDescriptionFailure> {
  @protected
  @override
  Either<IsValidLongDescriptionFailure, bool> execute(String? input) {
    if (input == null) {
      return const Left(NullLongDescriptionFailure());
    }

    if (input.isEmpty) {
      return const Left(EmptyLongDescriptionFailure());
    }

    final regEx = RegExp(r'^(?!\s*$).{100,500}$', dotAll: true);
    return Right(regEx.hasMatch(input));
  }

  @protected
  @override
  IsValidLongDescriptionFailure mapErrorToFailure(Object e, StackTrace st) {
    return InvalidLongDescriptionFailure(message: 'Invalid message', cause: e);
  }
}
