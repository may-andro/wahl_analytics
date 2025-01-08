import 'package:cache/cache.dart';
import 'package:feature_flag/src/data/model/feature_model.dart';

class FeatureFlagCache extends DBCache<FeatureModel> {
  FeatureFlagCache();

  @override
  String get dbName => 'feature_flag_db';

  @override
  String get tableName => 'feature_table';

  @override
  int get tableVersion => 1;

  @override
  List<String> get dbColumnNames =>
      ['name TEXT PRIMARY KEY, is_enabled INTEGER'];

  @override
  FeatureModel deserialize(Map<String, dynamic> map) {
    return FeatureModel.fromJson(map);
  }

  @override
  Map<String, dynamic> serialize(FeatureModel model) => model.toJson();
}
