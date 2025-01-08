import 'dart:async';

import 'package:meta/meta.dart';
import 'package:use_case/use_case.dart';
import 'package:wahl_analytics/src/feature/contact/domain/entity/entity.dart';
import 'package:wahl_analytics/src/feature/contact/domain/repository/repository.dart';

class BusinessContactFailure extends BasicFailure {
  const BusinessContactFailure({super.message, super.cause});
}

class GetBusinessContactUseCase
    extends BaseNoParamUseCase<BusinessContactEntity, BusinessContactFailure> {
  GetBusinessContactUseCase(this._contactRepository);

  final ContactRepository _contactRepository;

  @protected
  @override
  Future<Either<BusinessContactFailure, BusinessContactEntity>>
      execute() async {
    final businessContact = await _contactRepository.getBusinessContact();
    return Right(businessContact);
  }

  @protected
  @override
  BusinessContactFailure mapErrorToFailure(Object e, StackTrace st) {
    return BusinessContactFailure(message: e.toString(), cause: e);
  }
}
