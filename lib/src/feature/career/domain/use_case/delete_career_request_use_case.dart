import 'dart:async';

import 'package:use_case/use_case.dart';
import 'package:wahl_analytics/src/feature/career/domain/entity/entity.dart';
import 'package:wahl_analytics/src/feature/career/domain/repository/repository.dart';

class DeleteCareerRequestFailure extends BasicFailure {
  const DeleteCareerRequestFailure({super.message, super.cause});
}

class DeleteCareerRequestUseCase
    extends BaseUseCase<void, CareerEntity, DeleteCareerRequestFailure> {
  DeleteCareerRequestUseCase(this._careerRepository);

  final CareerRepository _careerRepository;

  @override
  FutureOr<Either<DeleteCareerRequestFailure, void>> execute(
    CareerEntity input,
  ) async {
    await _careerRepository.deleteCareerRequest(input);
    return const Right(null);
  }

  @override
  DeleteCareerRequestFailure mapErrorToFailure(Object e, StackTrace st) {
    return DeleteCareerRequestFailure(message: e.toString(), cause: e);
  }
}
