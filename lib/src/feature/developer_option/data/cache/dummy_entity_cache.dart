import 'package:cache/cache.dart';
import 'package:core/core.dart';
import 'package:wahl_analytics/src/feature/developer_option/domain/domain.dart';

class DummyEntityCache extends DBCache<DummyEntity> {
  DummyEntityCache();

  @override
  String get dbName => 'test_db';

  @override
  String get tableName => 'dummy_table';

  @override
  int get tableVersion => 1;

  @override
  List<String> get dbColumnNames => ['name TEXT'];

  @override
  DummyEntity deserialize(Map<String, dynamic> map) {
    return DummyEntity.fromJson(map);
  }

  @override
  Map<String, dynamic> serialize(DummyEntity model) {
    return model.toJson();
  }

  @override
  Duration get timeToLive => 1.minutes;
}
