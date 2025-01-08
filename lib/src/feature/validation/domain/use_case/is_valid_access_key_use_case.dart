import 'package:meta/meta.dart';
import 'package:use_case/use_case.dart';

sealed class IsValidAccessKeyFailure extends BasicFailure {
  const IsValidAccessKeyFailure({super.message, super.cause});
}

class InvalidAccessKeyFailure extends IsValidAccessKeyFailure {
  const InvalidAccessKeyFailure({super.message, super.cause});
}

class EmptyAccessKeyFailure extends IsValidAccessKeyFailure {
  const EmptyAccessKeyFailure();
}

class NullAccessKeyFailure extends IsValidAccessKeyFailure {
  const NullAccessKeyFailure();
}

class IsValidAccessKeyUseCase
    extends BaseUseCase<bool, String?, IsValidAccessKeyFailure> {
  @protected
  @override
  Either<IsValidAccessKeyFailure, bool> execute(String? input) {
    if (input == null) {
      return const Left(NullAccessKeyFailure());
    }

    if (input.isEmpty) {
      return const Left(EmptyAccessKeyFailure());
    }

    final regEx = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return Right(regEx.hasMatch(input));
  }

  @protected
  @override
  IsValidAccessKeyFailure mapErrorToFailure(Object e, StackTrace st) {
    return InvalidAccessKeyFailure(message: 'Invalid access key', cause: e);
  }
}
