import 'dart:async';

import 'package:meta/meta.dart';
import 'package:use_case/use_case.dart';
import 'package:wahl_analytics/src/feature/service/domain/entity/entity.dart';
import 'package:wahl_analytics/src/feature/service/domain/repository/repository.dart';

class UpdateAllLocaleBusinessServiceFailure extends BasicFailure {
  const UpdateAllLocaleBusinessServiceFailure({super.message, super.cause});
}

class UpdateAllLocaleBusinessServiceUseCase
    extends
        BaseUseCase<
          void,
          AllLocaleBusinessServiceEntity,
          UpdateAllLocaleBusinessServiceFailure
        > {
  UpdateAllLocaleBusinessServiceUseCase(this._serviceRepository);

  final ServiceRepository _serviceRepository;

  @protected
  @override
  FutureOr<Either<UpdateAllLocaleBusinessServiceFailure, void>> execute(
    AllLocaleBusinessServiceEntity input,
  ) async {
    await _serviceRepository.updateAllLocaleBusinessService(input);
    return const Right(null);
  }

  @protected
  @override
  UpdateAllLocaleBusinessServiceFailure mapErrorToFailure(
    Object e,
    StackTrace st,
  ) {
    return UpdateAllLocaleBusinessServiceFailure(
      message: e.toString(),
      cause: e,
    );
  }
}
