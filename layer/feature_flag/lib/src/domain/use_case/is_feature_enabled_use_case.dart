import 'dart:async';

import 'package:feature_flag/src/domain/entity/feature.dart';
import 'package:feature_flag/src/domain/repository/feature_flag_repository.dart';
import 'package:use_case/use_case.dart';

class FeatureFlagUnknownStatusFailure extends BasicFailure {
  const FeatureFlagUnknownStatusFailure({super.message, super.cause});
}

class IsFeatureEnabledUseCase
    extends BaseUseCase<bool, Feature, FeatureFlagUnknownStatusFailure> {
  IsFeatureEnabledUseCase(this._featureFlagRepository);

  final FeatureFlagRepository _featureFlagRepository;

  @override
  FutureOr<Either<FeatureFlagUnknownStatusFailure, bool>> execute(
    Feature input,
  ) async {
    final status = await _featureFlagRepository.isFeatureEnabled(input);
    return Right(status);
  }

  @override
  FeatureFlagUnknownStatusFailure mapErrorToFailure(Object e, StackTrace st) {
    return FeatureFlagUnknownStatusFailure(message: e.toString(), cause: e);
  }
}
