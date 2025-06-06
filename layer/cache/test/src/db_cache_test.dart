import 'package:cache/src/db_cache.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class TestModel {
  TestModel({required this.name});

  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(name: json['name'] as String);
  }

  final String name;

  Map<String, dynamic> toJson() => {'name': name};
}

class TestModelCache extends DBCache<TestModel> {
  bool isDBExpired = false;

  @override
  String get dbName => 'test_db';

  @override
  String get tableName => 'test_table';

  @override
  int get tableVersion => 1;

  @override
  List<String> get dbColumnNames => ['name TEXT'];

  @override
  TestModel deserialize(Map<String, dynamic> map) => TestModel.fromJson(map);

  @override
  Map<String, dynamic> serialize(TestModel model) => model.toJson();

  @override
  bool get isExpired => isDBExpired;
}

void main() {
  group('DBCache', () {
    late TestModelCache testModelCache;

    setUpAll(() {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    });

    setUp(() async {
      await databaseFactory.deleteDatabase('test_db.db');
      testModelCache = TestModelCache();
      await testModelCache.initializeDB();
    });

    tearDownAll(() async {
      await databaseFactory.deleteDatabase('test_db.db');
    });

    test('should initialize db correctly', () async {
      final db = await testModelCache.initializeDB();
      expect(db, isNotNull);
    });

    test('should insert and retrieve data', () async {
      final testModel = TestModel(name: 'Test');
      await testModelCache.put(testModel);

      final result = await testModelCache.getAll();

      expect(result.length, 1);
      expect(result.first.name, 'Test');
    });

    test('should delete all data', () async {
      final testModel = TestModel(name: 'Test');
      await testModelCache.put(testModel);

      await testModelCache.delete('name = ?', ['Test']);

      final results = await testModelCache.getAll();

      await pumpEventQueue();

      expect(results.isEmpty, isTrue);
    });

    test('should deletes expired items', () async {
      final testModel = TestModel(name: 'Test');
      await testModelCache.put(testModel);

      testModelCache.isDBExpired = true;
      await testModelCache.getAll();

      final db = await testModelCache.initializeDB();
      final remainingItems = await db.query(testModelCache.tableName);

      expect(remainingItems.length, 0);
    });

    test('should return empty database when nothing is present', () async {
      final items = await testModelCache.getAll();
      expect(items.length, 0);
    });
  });
}
