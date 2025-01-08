import 'package:core/core.dart';
import 'package:feature_flag/src/data/model/feature_model.dart';
import 'package:feature_flag/src/domain/domain.dart';

class FeatureModelMapper implements Mapper<FeatureModel, FeatureFlag?> {
  @override
  FeatureFlag? map(FeatureModel from) {
    try {
      return FeatureFlag(
        Feature.getFeature(from.name),
        from.isEnabled == 1,
      );
    } catch (e) {
      return null;
    }
  }
}
