import 'package:core/core.dart';
import 'package:feature_flag/src/domain/domain.dart';
import 'package:feature_flag/src/domain/repository/feature_flag_repository.dart';
import 'package:firebase/firebase.dart';

class RemoteFeatureFlagRepository implements FeatureFlagRepository {
  RemoteFeatureFlagRepository(this._fbRemoteConfigController);

  final FbRemoteConfigController _fbRemoteConfigController;

  final Map<String, bool> _remoteFeatureFlags = {};

  @override
  void initFeatureFlags() {
    final configValues = _fbRemoteConfigController.getAllConfigsValue();
    _remoteFeatureFlags.clear();
    for (final entry in configValues.entries) {
      final key = entry.key;
      final value = entry.value;
      _remoteFeatureFlags[key] = value.asBool();
    }
  }

  @override
  List<FeatureFlag> getFeatureFlags() {
    return _remoteFeatureFlags.entries
        .map((entry) {
          final feature = Feature.values.firstWhereOrNull(
            (feature) => feature.key == entry.key,
          );
          if (feature != null) {
            return FeatureFlag(feature, entry.value);
          }
          return null;
        })
        .whereType<FeatureFlag>()
        .toList();
  }

  @override
  bool isFeatureEnabled(Feature feature) {
    return _remoteFeatureFlags[feature.key] ?? false;
  }

  @override
  void reset() {
    _remoteFeatureFlags.clear();
    initFeatureFlags();
  }

  @override
  void updateFeatureFlag(FeatureFlag featureFlag) {
    _remoteFeatureFlags[featureFlag.feature.key] = featureFlag.isEnabled;
  }
}
