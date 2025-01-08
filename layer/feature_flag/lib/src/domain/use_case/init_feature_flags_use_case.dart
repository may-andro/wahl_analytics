import 'dart:async';

import 'package:feature_flag/src/domain/repository/feature_flag_repository.dart';
import 'package:use_case/use_case.dart';

class InitFeatureFlagsFailure extends BasicFailure {
  const InitFeatureFlagsFailure({super.message, super.cause});
}

class InitFeatureFlagsUseCase
    extends BaseNoParamUseCase<void, InitFeatureFlagsFailure> {
  InitFeatureFlagsUseCase(this._featureFlagRepository);

  final FeatureFlagRepository _featureFlagRepository;

  @override
  FutureOr<Either<InitFeatureFlagsFailure, void>> execute() async {
    await _featureFlagRepository.initFeatureFlags();
    return const Right(null);
  }

  @override
  InitFeatureFlagsFailure mapErrorToFailure(Object e, StackTrace st) {
    return InitFeatureFlagsFailure(message: e.toString(), cause: e);
  }
}
