import 'dart:async';

import 'package:feature_flag/src/domain/entity/entity.dart';

abstract class FeatureFlagRepository {
  FutureOr<void> initFeatureFlags();

  FutureOr<List<FeatureFlag>> getFeatureFlags();

  FutureOr<bool> isFeatureEnabled(Feature feature);

  void updateFeatureFlag(FeatureFlag featureFlag);

  FutureOr<void> reset();
}
