import 'dart:async';

import 'package:feature_flag/src/domain/entity/entity.dart';
import 'package:feature_flag/src/domain/repository/feature_flag_repository.dart';
import 'package:use_case/use_case.dart';

class FeatureFlagUpdateFailure extends BasicFailure {
  const FeatureFlagUpdateFailure({super.message, super.cause});
}

class UpdateFeatureFlagUseCase
    extends BaseUseCase<void, FeatureFlag, FeatureFlagUpdateFailure> {
  UpdateFeatureFlagUseCase(this._featureFlagRepository);

  final FeatureFlagRepository _featureFlagRepository;

  @override
  FutureOr<Either<FeatureFlagUpdateFailure, void>> execute(
    FeatureFlag input,
  ) {
    _featureFlagRepository.updateFeatureFlag(input);
    return const Right(null);
  }

  @override
  FeatureFlagUpdateFailure mapErrorToFailure(Object e, StackTrace st) {
    return FeatureFlagUpdateFailure(message: e.toString(), cause: e);
  }
}
