import 'package:meta/meta.dart';
import 'package:use_case/use_case.dart';

sealed class IsValidCountryFailure extends BasicFailure {
  const IsValidCountryFailure({super.message, super.cause});
}

class InvalidCountryFailure extends IsValidCountryFailure {
  const InvalidCountryFailure({super.message, super.cause});
}

class EmptyCountryFailure extends IsValidCountryFailure {
  const EmptyCountryFailure();
}

class NullCountryFailure extends IsValidCountryFailure {
  const NullCountryFailure();
}

class IsValidCountryUseCase
    extends BaseUseCase<bool, String?, IsValidCountryFailure> {
  @protected
  @override
  Either<IsValidCountryFailure, bool> execute(String? input) {
    if (input == null) {
      return const Left(NullCountryFailure());
    }

    if (input.isEmpty) {
      return const Left(EmptyCountryFailure());
    }

    final bool isValidCountry = RegExp(r"^[a-zA-Z\s'-]{2,50}$").hasMatch(input);
    return Right(isValidCountry);
  }

  @protected
  @override
  IsValidCountryFailure mapErrorToFailure(Object e, StackTrace st) {
    return InvalidCountryFailure(message: 'Invalid Country', cause: e);
  }
}
