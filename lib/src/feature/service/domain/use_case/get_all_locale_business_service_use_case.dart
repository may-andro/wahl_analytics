import 'dart:async';

import 'package:meta/meta.dart';
import 'package:use_case/use_case.dart';
import 'package:wahl_analytics/src/feature/service/domain/entity/entity.dart';
import 'package:wahl_analytics/src/feature/service/domain/repository/repository.dart';

class GetAllLocaleBusinessServiceFailure extends BasicFailure {
  const GetAllLocaleBusinessServiceFailure({super.message, super.cause});
}

class GetAllLocaleBusinessServiceUseCase extends BaseNoParamUseCase<
    AllLocaleBusinessServiceEntity, GetAllLocaleBusinessServiceFailure> {
  GetAllLocaleBusinessServiceUseCase(this._serviceRepository);

  final ServiceRepository _serviceRepository;

  @protected
  @override
  Future<
      Either<GetAllLocaleBusinessServiceFailure,
          AllLocaleBusinessServiceEntity>> execute() async {
    final businessService = await _serviceRepository.getBusinessService();
    return Right(businessService);
  }

  @protected
  @override
  GetAllLocaleBusinessServiceFailure mapErrorToFailure(
    Object e,
    StackTrace st,
  ) {
    return GetAllLocaleBusinessServiceFailure(message: e.toString(), cause: e);
  }
}
