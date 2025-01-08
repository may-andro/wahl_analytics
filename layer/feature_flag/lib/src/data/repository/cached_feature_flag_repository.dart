import 'dart:async';

import 'package:feature_flag/src/data/cache/feature_flag_cache.dart';
import 'package:feature_flag/src/data/mapper/mapper.dart';
import 'package:feature_flag/src/domain/domain.dart';
import 'package:feature_flag/src/domain/repository/feature_flag_repository.dart';

class CachedFeatureFlagRepository implements FeatureFlagRepository {
  CachedFeatureFlagRepository(
    this._featureFlagRepositoryDelegate,
    this._featureFlagCache,
    this._featureFlagMapper,
    this._featureModelMapper,
  );

  final FeatureFlagRepository _featureFlagRepositoryDelegate;
  final FeatureFlagCache _featureFlagCache;
  final FeatureModelMapper _featureModelMapper;
  final FeatureFlagMapper _featureFlagMapper;

  @override
  Future<void> initFeatureFlags() async {
    final cachedData = await _featureFlagCache.getAll();
    if (cachedData.isNotEmpty) return;

    await _featureFlagRepositoryDelegate.initFeatureFlags();
    final featureFlags = await _featureFlagRepositoryDelegate.getFeatureFlags();

    final featureModels = featureFlags.map(_featureFlagMapper.map).toList();
    await Future.wait(
      featureModels.map((flag) => _featureFlagCache.put(flag)),
    );
  }

  @override
  Future<List<FeatureFlag>> getFeatureFlags() async {
    final featureModels = await _featureFlagCache.getAll();
    return featureModels
        .map(_featureModelMapper.map)
        .whereType<FeatureFlag>()
        .toList();
  }

  @override
  Future<bool> isFeatureEnabled(Feature feature) async {
    final featureFlagCache = await _featureFlagCache.get(
      where: 'name = ?',
      arguments: [feature.key],
    );
    return featureFlagCache?.isEnabled == 1;
  }

  @override
  Future<void> reset() async {
    await _featureFlagCache.deleteAll();
    await initFeatureFlags();
  }

  @override
  void updateFeatureFlag(FeatureFlag featureFlag) {
    _featureFlagCache.put(_featureFlagMapper.map(featureFlag));
  }
}
