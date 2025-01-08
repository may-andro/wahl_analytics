# Cache Library

A versatile caching library for Dart applications, offering support for database, memory, and key-value storage.

## Table of Contents

- [Getting Started](#getting-started)
- [Usage](#usage)
    * [Database Cache](#database-cache)
    * [Key Value Cache](#key-value-cache)
    * [Memory Cache](#memory-cache)

## Getting Started

This library provides a unified caching interface with implementations for various storage backends like SQLite, SharedPreferences, and in-memory caching. It simplifies cache management by handling expiration and serialization.

### Add the dependency in `pubspec.yaml`

```yaml
cache:
  path: layer/cache
```

## Architecture

### Database Cache

DBCache uses SQLite for caching data. It’s suitable for larger datasets and complex structures.

```dart
@JsonSerializable()
class DummyEntity {
  DummyEntity({
    required this.name,
  });

  factory DummyEntity.fromJson(Map<String, dynamic> json) =>
          _$DummyEntityFromJson(json);

  @JsonKey(name: 'name')
  final String name;

  Map<String, dynamic> toJson() => _$DummyEntityToJson(this);
}

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
```

### Key Value Cache

KeyValueCache uses SharedPreferences for lightweight key-value storage, making it ideal for preferences or small data sets.

```dart
class UserPreferencesCache extends KeyValueCache<UserPreferences> {
  UserPreferencesCache() : super('user_preferences');

  @override
  UserPreferences deserializeValue(Map<String, dynamic> map) => UserPreferences.fromJson(map);

  @override
  Map<String, dynamic> serializeValue(UserPreferences value) => value.toJson();
}
```

### Memory Cache

The MemoryCache class is an in-memory implementation of the Cache interface. This is best suited for temporary data storage that doesn’t need to persist across app sessions.

```dart
class TestMemoryCache extends MemoryCache<bool> {
  @override
  Duration get timeToLive => 30.minutes;
}
```



