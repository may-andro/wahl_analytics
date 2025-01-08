import 'dart:async';

import 'package:meta/meta.dart';
import 'package:use_case/use_case.dart';
import 'package:wahl_analytics/src/feature/team/domain/entity/entity.dart';
import 'package:wahl_analytics/src/feature/team/domain/repository/repository.dart';

class BusinessTeamFailure extends BasicFailure {
  const BusinessTeamFailure({super.message, super.cause});
}

class GetBusinessTeamUseCase
    extends BaseNoParamUseCase<BusinessTeamEntity, BusinessTeamFailure> {
  GetBusinessTeamUseCase(this._teamRepository);

  final TeamRepository _teamRepository;

  @protected
  @override
  Future<Either<BusinessTeamFailure, BusinessTeamEntity>> execute() async {
    final businessTeam = await _teamRepository.getBusinessTeam();
    return Right(businessTeam);
  }

  @protected
  @override
  BusinessTeamFailure mapErrorToFailure(Object e, StackTrace st) {
    return BusinessTeamFailure(message: e.toString(), cause: e);
  }
}
