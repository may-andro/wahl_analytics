import 'dart:async';

import 'package:meta/meta.dart';
import 'package:use_case/use_case.dart';
import 'package:wahl_analytics/src/feature/service/domain/entity/entity.dart';
import 'package:wahl_analytics/src/feature/service/domain/repository/repository.dart';

class BusinessServiceFailure extends BasicFailure {
  const BusinessServiceFailure({super.message, super.cause});
}

class GetBusinessServiceUseCase
    extends BaseNoParamUseCase<BusinessServiceEntity, BusinessServiceFailure> {
  GetBusinessServiceUseCase(this._serviceRepository);

  final ServiceRepository _serviceRepository;

  @protected
  @override
  Future<Either<BusinessServiceFailure, BusinessServiceEntity>>
  execute() async {
    final businessService = await _serviceRepository
        .getBusinessServiceForLocale();
    return Right(businessService);
  }

  @protected
  @override
  BusinessServiceFailure mapErrorToFailure(Object e, StackTrace st) {
    return BusinessServiceFailure(message: e.toString(), cause: e);
  }
}
