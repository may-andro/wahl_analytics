import 'dart:convert';

import 'package:cache/src/key_value_cache.dart';
import 'package:dependency_injection/dependency_injection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _TestCache extends KeyValueCache<String> {
  _TestCache() : super('test_cache');

  @override
  String deserializeValue(Map<String, dynamic> map) {
    return map['name'] as String;
  }

  @override
  Map<String, dynamic> serializeValue(String value) {
    return {'name': value};
  }

  @override
  Duration get timeToLive => const Duration(milliseconds: 300);
}

class MockedSharedPreferences extends Mock implements SharedPreferences {
  void mockGetString(String? expected) {
    when(() => getString(any())).thenReturn(expected);
  }

  void mockGetInt(int? expected) {
    when(() => getInt(any())).thenReturn(expected);
  }

  void mockPut() {
    when(() => setString(any(), any())).thenAnswer((_) async {
      return true;
    });
    when(() => setInt(any(), any())).thenAnswer((_) async {
      return true;
    });
  }

  void mockRemove() {
    when(() => remove(any())).thenAnswer((_) async {
      return true;
    });
  }
}

void main() {
  group(KeyValueCache, () {
    late KeyValueCache<String> keyValueCache;
    late MockedSharedPreferences mockedSharedPreferences;
    setUp(() {
      mockedSharedPreferences = MockedSharedPreferences();
      DIController().serviceLocator.registerSingleton<SharedPreferences>(
            () => mockedSharedPreferences,
          );
      keyValueCache = _TestCache();
    });

    tearDown(() {
      DIController().serviceLocator.reset();
    });

    group('get', () {
      test('should return null when cache does not exists', () async {
        mockedSharedPreferences.mockGetString(null);
        mockedSharedPreferences.mockRemove();
        mockedSharedPreferences.mockPut();

        final result = await keyValueCache.get();

        verifyNever(() => mockedSharedPreferences.remove(any()));
        expect(result, isNull);
      });

      test('should return null when cache is expired', () async {
        mockedSharedPreferences.mockGetString(
          jsonEncode(keyValueCache.serializeValue('test')),
        );
        mockedSharedPreferences.mockRemove();
        mockedSharedPreferences.mockPut();

        final result = await keyValueCache.get();

        verify(() => mockedSharedPreferences.remove(any())).called(2);
        expect(result, isNull);
      });

      test('should return value when unexpired', () async {
        mockedSharedPreferences.mockGetString(
          jsonEncode(keyValueCache.serializeValue('test')),
        );
        mockedSharedPreferences.mockGetInt(
          DateTime.now().millisecondsSinceEpoch,
        );
        mockedSharedPreferences.mockRemove();
        mockedSharedPreferences.mockPut();

        await keyValueCache.put('test');
        final result = await keyValueCache.get();

        verifyNever(() => mockedSharedPreferences.remove(any()));
        expect(result, isNotNull);
      });
    });

    group('put', () {
      test('should set the entry and expiration', () async {
        mockedSharedPreferences.mockPut();

        await keyValueCache.put('Test');

        verify(
          () => mockedSharedPreferences.setString(any(), any()),
        ).called(1);
        verify(
          () => mockedSharedPreferences.setInt(any(), any()),
        ).called(1);
      });
    });

    group('delete', () {
      test('should delete the entry and expiration', () async {
        mockedSharedPreferences.mockRemove();

        await keyValueCache.delete();
        verify(() => mockedSharedPreferences.remove(any())).called(2);
      });
    });
  });
}
