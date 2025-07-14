import 'package:cache/src/cache.dart';
import 'package:error_reporter/error_reporter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

const _cacheTimestampKey = 'cachedTimestamp';

class DBNotInitialisedException implements FatalException {}

// Only supported for Android, IOS and Mac OS
abstract class DBCache<T> extends Cache {
  DBCache();

  @visibleForTesting
  @protected
  Database? db;

  int _cacheTimestamp = 0;

  String get dbName;

  String get tableName;

  int get tableVersion;

  List<String> get dbColumnNames;

  Map<String, dynamic> serialize(T model);

  T deserialize(Map<String, dynamic> map);

  @override
  int get lastCachedTimestamp => _cacheTimestamp;

  Future<Database> initializeDB() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/$dbName.db';
    return db = await openDatabase(
      path,
      version: tableVersion,
      onCreate: _createDatabase,
    );
  }

  Future<void> put(T model) async {
    db ??= await initializeDB();

    final temptDb = db;
    if (temptDb == null) {
      throw DBNotInitialisedException();
    }

    final timestamp = DateTime.now().millisecondsSinceEpoch;

    final values = {...serialize(model), _cacheTimestampKey: timestamp};
    await temptDb.transaction((txn) async {
      await txn.insert(
        tableName,
        values,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });

    _cacheTimestamp = timestamp;
  }

  Future<List<T>> getAll() async {
    db ??= await initializeDB();

    final temptDb = db;
    if (temptDb == null) {
      throw DBNotInitialisedException();
    }

    final cachedList = <T>[];

    final cachedDataMaps = await temptDb
        .transaction<List<Map<String, dynamic>>>((txn) async {
          return await txn.query(tableName);
        });

    final expiredItems = <Map<String, dynamic>>[];

    for (final map in cachedDataMaps) {
      if (_isCachedItemValid(map)) {
        cachedList.add(deserialize(map));
      } else {
        expiredItems.add(map);
      }
    }

    _deleteExpiredEntries(expiredItems);

    return cachedList;
  }

  bool _isCachedItemValid(Map<String, dynamic> map) {
    if (map.containsKey(_cacheTimestampKey) &&
        map[_cacheTimestampKey] != null) {
      _cacheTimestamp = map[_cacheTimestampKey] as int;
      return !isExpired;
    }
    return false;
  }

  void _deleteExpiredEntries(List<Map<String, dynamic>> expiredItems) {
    for (final map in expiredItems) {
      _cacheTimestamp = map[_cacheTimestampKey] as int;
      delete('$_cacheTimestampKey = ?', [_cacheTimestamp]);
    }
  }

  Future<T?> get({String? where, List<Object?>? arguments}) async {
    db ??= await initializeDB();

    final temptDb = db;
    if (temptDb == null) {
      throw DBNotInitialisedException();
    }

    return await temptDb.transaction<T?>((txn) async {
      final results = await txn.query(
        tableName,
        where: where,
        whereArgs: arguments,
        limit: 1,
      );

      if (results.isNotEmpty) {
        return deserialize(
          results.first,
        ); // Convert the first result into the model
      }

      return null;
    });
  }

  Future<void> delete(String? where, [List<Object?>? arguments]) async {
    db ??= await initializeDB();

    final temptDb = db;
    if (temptDb == null) {
      throw DBNotInitialisedException();
    }

    await temptDb.transaction((txn) async {
      await txn.delete(tableName, where: where, whereArgs: arguments);
    });
  }

  Future<void> deleteAll() async {
    db ??= await initializeDB();

    final temptDb = db;
    if (temptDb == null) {
      throw DBNotInitialisedException();
    }

    await temptDb.transaction((txn) async {
      await txn.delete(tableName);
    });
  }

  Future<void> _createDatabase(Database db, int version) async {
    return await db.execute(
      'CREATE TABLE $tableName (_id INTEGER, ${dbColumnNames.join(', ')}, $_cacheTimestampKey INTEGER NOT NULL)',
    );
  }
}
