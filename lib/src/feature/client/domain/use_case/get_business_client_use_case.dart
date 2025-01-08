import 'dart:async';

import 'package:meta/meta.dart';
import 'package:use_case/use_case.dart';
import 'package:wahl_analytics/src/feature/client/domain/entity/entity.dart';
import 'package:wahl_analytics/src/feature/client/domain/repository/repository.dart';

class BusinessClientFailure extends BasicFailure {
  const BusinessClientFailure({super.message, super.cause});
}

class GetBusinessClientUseCase
    extends BaseNoParamUseCase<BusinessClientEntity, BusinessClientFailure> {
  GetBusinessClientUseCase(this._clientRepository);

  final ClientRepository _clientRepository;

  @protected
  @override
  Future<Either<BusinessClientFailure, BusinessClientEntity>> execute() async {
    final businessClient = await _clientRepository.getBusinessClient();
    return Right(businessClient);
  }

  @protected
  @override
  BusinessClientFailure mapErrorToFailure(Object e, StackTrace st) {
    return BusinessClientFailure(message: e.toString(), cause: e);
  }
}
