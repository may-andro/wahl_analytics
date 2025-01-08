import 'package:cache/src/memory_cache.dart';
import 'package:flutter_test/flutter_test.dart';

class _TestMemoryCache extends MemoryCache<String> {
  @override
  Duration get timeToLive => const Duration(milliseconds: 300);
}

void main() {
  group(MemoryCache, () {
    late MemoryCache<String> memoryCache;

    setUp(() {
      memoryCache = _TestMemoryCache();
    });

    group('get', () {
      test('should return null by when no value is set', () {
        final result = memoryCache.get();
        expect(result, isNull);
      });

      test('should return null value when expired', () async {
        memoryCache.put('Test');
        await Future<dynamic>.delayed(const Duration(milliseconds: 301));
        final result = memoryCache.get();
        expect(result, isNull);
      });

      test('should return value when unexpired', () {
        memoryCache.put('Test');
        final result = memoryCache.get();
        expect(result, isNotNull);
      });
    });

    group('put', () {
      test('should cache the value', () {
        memoryCache.put('Test');
        expect(memoryCache.get(), 'Test');
      });
    });

    group('delete', () {
      test('should delete the value', () {
        memoryCache.delete();
        expect(memoryCache.get(), isNull);
      });
    });
  });
}
