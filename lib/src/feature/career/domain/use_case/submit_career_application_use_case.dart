import 'dart:async';

import 'package:use_case/use_case.dart';
import 'package:wahl_analytics/src/feature/career/domain/entity/entity.dart';
import 'package:wahl_analytics/src/feature/career/domain/exception/exception.dart';
import 'package:wahl_analytics/src/feature/career/domain/repository/repository.dart';

sealed class SubmitCareerApplicationFailure extends BasicFailure {
  const SubmitCareerApplicationFailure({super.message, super.cause});
}

class ApplicationUploadFailure extends SubmitCareerApplicationFailure {
  const ApplicationUploadFailure({super.message, super.cause});
}

class ApplicationSubmissionFailure extends SubmitCareerApplicationFailure {
  const ApplicationSubmissionFailure({super.message, super.cause});
}

class ApplicationSubmissionUnknownFailure
    extends SubmitCareerApplicationFailure {
  const ApplicationSubmissionUnknownFailure({super.message, super.cause});
}

class SubmitCareerApplicationUseCase
    extends BaseUseCase<void, CareerEntity, SubmitCareerApplicationFailure> {
  SubmitCareerApplicationUseCase(this._careerRepository);

  final CareerRepository _careerRepository;

  @override
  FutureOr<Either<SubmitCareerApplicationFailure, void>> execute(
    CareerEntity input,
  ) async {
    return Right(await _careerRepository.submitCareerApplication(input));
  }

  @override
  SubmitCareerApplicationFailure mapErrorToFailure(Object e, StackTrace st) {
    if (e is CareerException) {
      switch (e) {
        case UploadDocumentFailureException():
          return ApplicationUploadFailure(
            message: e.toString(),
            cause: e.cause,
          );
        case UnknownCareerException():
          return ApplicationSubmissionFailure(
            message: e.toString(),
            cause: e.cause,
          );
      }
    }

    return ApplicationSubmissionUnknownFailure(message: e.toString(), cause: e);
  }
}
