import 'dart:async';

import 'package:use_case/use_case.dart';
import 'package:wahl_analytics/src/feature/career/domain/entity/entity.dart';
import 'package:wahl_analytics/src/feature/career/domain/repository/repository.dart';

class GetCareersRequestFailure extends BasicFailure {
  const GetCareersRequestFailure({super.message, super.cause});
}

class GetCareersRequestUseCase
    extends BaseNoParamUseCase<List<CareerEntity>, GetCareersRequestFailure> {
  GetCareersRequestUseCase(this._careerRepository);

  final CareerRepository _careerRepository;

  @override
  FutureOr<Either<GetCareersRequestFailure, List<CareerEntity>>>
      execute() async {
    final careers = await _careerRepository.getCareersRequest();
    return Right(careers);
  }

  @override
  GetCareersRequestFailure mapErrorToFailure(Object e, StackTrace st) {
    return GetCareersRequestFailure(message: e.toString(), cause: e);
  }
}
