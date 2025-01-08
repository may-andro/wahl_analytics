import 'package:cache/src/cache.dart';

class MemoryCache<T> extends Cache {
  T? _model;
  int? _cachedTimestamp;

  T? get() {
    if (_model == null) return null;
    if (isExpired) {
      delete();
      return null;
    }
    return _model;
  }

  void put(T model) {
    _model = model;
    _cachedTimestamp = DateTime.now().millisecondsSinceEpoch;
  }

  void delete() {
    _model = null;
    _cachedTimestamp = null;
  }

  @override
  int get lastCachedTimestamp => _cachedTimestamp ?? 0;
}
