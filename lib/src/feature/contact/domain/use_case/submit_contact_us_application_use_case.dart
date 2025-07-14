import 'dart:async';

import 'package:use_case/use_case.dart';
import 'package:wahl_analytics/src/feature/contact/domain/entity/entity.dart';
import 'package:wahl_analytics/src/feature/contact/domain/repository/repository.dart';

class SubmitContactUsApplicationFailure extends BasicFailure {
  const SubmitContactUsApplicationFailure({super.message, super.cause});
}

class SubmitContactUsApplicationUseCase
    extends
        BaseUseCase<void, ContactUsEntity, SubmitContactUsApplicationFailure> {
  SubmitContactUsApplicationUseCase(this._contactRepository);

  final ContactRepository _contactRepository;

  @override
  FutureOr<Either<SubmitContactUsApplicationFailure, void>> execute(
    ContactUsEntity input,
  ) async {
    return Right(await _contactRepository.submitApplication(input));
  }

  @override
  SubmitContactUsApplicationFailure mapErrorToFailure(Object e, StackTrace st) {
    return SubmitContactUsApplicationFailure(message: e.toString(), cause: st);
  }
}
