import 'dart:async';

import 'package:core/core.dart';
import 'package:feature_flag/src/domain/domain.dart';
import 'package:feature_flag/src/domain/repository/feature_flag_repository.dart';

class BuildFeatureFlagRepository implements FeatureFlagRepository {
  BuildFeatureFlagRepository(
    BuildConfig buildConfig,
    this._cacheRepositoryDelegate,
    this._remoteRepositoryDelegate,
  ) : _isCacheEnabled = buildConfig.buildEnvironment.isFeatureFlagCached;

  final FeatureFlagRepository _cacheRepositoryDelegate;
  final FeatureFlagRepository _remoteRepositoryDelegate;
  final bool _isCacheEnabled;

  @override
  FutureOr<void> initFeatureFlags() {
    if (_isCacheEnabled) return _cacheRepositoryDelegate.initFeatureFlags();
    return _remoteRepositoryDelegate.initFeatureFlags();
  }

  @override
  FutureOr<bool> isFeatureEnabled(Feature feature) {
    if (_isCacheEnabled) {
      return _cacheRepositoryDelegate.isFeatureEnabled(
        feature,
      );
    }
    return _remoteRepositoryDelegate.isFeatureEnabled(feature);
  }

  @override
  FutureOr<List<FeatureFlag>> getFeatureFlags() {
    if (_isCacheEnabled) {
      return _cacheRepositoryDelegate.getFeatureFlags();
    }
    return _remoteRepositoryDelegate.getFeatureFlags();
  }

  @override
  FutureOr<void> reset() {
    if (_isCacheEnabled) {
      return _cacheRepositoryDelegate.reset();
    }
    return _remoteRepositoryDelegate.reset();
  }

  @override
  void updateFeatureFlag(FeatureFlag featureFlag) {
    if (_isCacheEnabled) {
      return _cacheRepositoryDelegate.updateFeatureFlag(featureFlag);
    }
    return _remoteRepositoryDelegate.updateFeatureFlag(featureFlag);
  }
}
