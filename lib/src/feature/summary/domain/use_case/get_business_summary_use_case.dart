import 'dart:async';

import 'package:meta/meta.dart';
import 'package:use_case/use_case.dart';
import 'package:wahl_analytics/src/feature/summary/domain/entity/entity.dart';
import 'package:wahl_analytics/src/feature/summary/domain/repository/repository.dart';

class BusinessSummaryFailure extends BasicFailure {
  const BusinessSummaryFailure({super.message, super.cause});
}

class GetBusinessSummaryUseCase
    extends BaseNoParamUseCase<BusinessSummaryEntity, BusinessSummaryFailure> {
  GetBusinessSummaryUseCase(this._summaryRepository);

  final SummaryRepository _summaryRepository;

  @protected
  @override
  Future<Either<BusinessSummaryFailure, BusinessSummaryEntity>>
      execute() async {
    final businessSummary = await _summaryRepository.getBusinessSummary();
    return Right(businessSummary);
  }

  @protected
  @override
  BusinessSummaryFailure mapErrorToFailure(Object e, StackTrace st) {
    return BusinessSummaryFailure(message: e.toString(), cause: e);
  }
}
