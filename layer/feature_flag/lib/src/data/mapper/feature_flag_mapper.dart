import 'package:core/core.dart';
import 'package:feature_flag/src/data/model/feature_model.dart';
import 'package:feature_flag/src/domain/domain.dart';

class FeatureFlagMapper implements Mapper<FeatureFlag, FeatureModel> {
  @override
  FeatureModel map(FeatureFlag from) {
    return FeatureModel(
      name: from.feature.key,
      isEnabled: from.isEnabled ? 1 : 0,
    );
  }
}
