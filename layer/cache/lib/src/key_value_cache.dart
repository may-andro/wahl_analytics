import 'dart:convert';

import 'package:cache/src/cache.dart';
import 'package:dependency_injection/dependency_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class KeyValueCache<T> extends Cache {
  KeyValueCache(
    this._cacheKey,
  ) {
    _sharedPreferences = DIController().serviceLocator.get<SharedPreferences>();
  }

  late SharedPreferences _sharedPreferences;
  final String _cacheKey;

  T deserializeValue(Map<String, dynamic> map);

  Map<String, dynamic> serializeValue(T value);

  @override
  int get lastCachedTimestamp => _sharedPreferences.getInt(_expirationKey) ?? 0;

  Future<T?> get() async {
    final value = _sharedPreferences.getString(_cacheKey);
    if (value == null) return null;
    if (isExpired) {
      await delete();
      return null;
    }
    return deserializeValue(jsonDecode(value) as Map<String, dynamic>);
  }

  Future<bool> put(T value) {
    _sharedPreferences.setInt(
      _expirationKey,
      DateTime.now().millisecondsSinceEpoch,
    );
    return _sharedPreferences.setString(
      _cacheKey,
      jsonEncode(serializeValue(value)),
    );
  }

  Future<bool> delete() {
    _sharedPreferences.remove(_expirationKey);
    return _sharedPreferences.remove(_cacheKey);
  }

  String get _expirationKey => '$_cacheKey.expiration';
}
