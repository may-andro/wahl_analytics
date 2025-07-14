import 'dart:async';

import 'package:feature_flag/src/domain/repository/feature_flag_repository.dart';
import 'package:use_case/use_case.dart';

class ResetFeatureFlagsUseCase extends BaseNoParamUseCase<void, NoFailure> {
  ResetFeatureFlagsUseCase(this._featureFlagRepository);

  final FeatureFlagRepository _featureFlagRepository;

  @override
  FutureOr<Either<NoFailure, void>> execute() async {
    await _featureFlagRepository.reset();
    return const Right(null);
  }

  @override
  NoFailure mapErrorToFailure(Object e, StackTrace st) {
    return NoFailure();
  }
}
