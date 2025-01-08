import 'package:feature_flag/src/data/data.dart';
import 'package:feature_flag/src/data/mapper/mapper.dart';
import 'package:feature_flag/src/data/model/feature_model.dart';
import 'package:feature_flag/src/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_mock/src/data/cache/mock_feature_flag_cache.dart';
import '../../../_mock/src/domain/mock_feature_flag_repository.dart';

void main() {
  group('CachedFeatureFlagRepository', () {
    late CachedFeatureFlagRepository repository;

    late MockFeatureFlagRepository mockFeatureFlagRepository;
    late MockFeatureFlagCache mockFeatureFlagCache;

    setUp(() {
      mockFeatureFlagRepository = MockFeatureFlagRepository();
      mockFeatureFlagCache = MockFeatureFlagCache();

      repository = CachedFeatureFlagRepository(
        mockFeatureFlagRepository,
        mockFeatureFlagCache,
        FeatureFlagMapper(),
        FeatureModelMapper(),
      );
    });

    setUpAll(() {
      registerFallbackValue(
        FeatureModel(name: 'contact_us_home_fab', isEnabled: 0),
      );
    });

    group('initFeatureFlags', () {
      test('should do nothing when cache is available', () async {
        mockFeatureFlagCache.mockGetAll(
          [FeatureModel(name: 'name', isEnabled: 0)],
        );

        await repository.initFeatureFlags();

        verifyNever(mockFeatureFlagRepository.initFeatureFlags);
      });

      test('should cache data when cache is unavailable', () async {
        const featureFlags = [
          FeatureFlag(Feature.contactUsHomeFab, false),
          FeatureFlag(Feature.languageSwitcher, true),
        ];
        mockFeatureFlagCache.mockGetAll([]);
        mockFeatureFlagCache.mockPut();
        mockFeatureFlagRepository.mockInitFeatureFlags();
        mockFeatureFlagRepository.mockGetFeatureFlags(featureFlags);

        await repository.initFeatureFlags();

        verify(mockFeatureFlagRepository.initFeatureFlags).called(1);
        verify(mockFeatureFlagRepository.getFeatureFlags).called(1);
        verify(
          () => mockFeatureFlagCache.put(any()),
        ).called(featureFlags.length);
      });

      test('should throw exception when cache throw exception', () async {
        mockFeatureFlagCache.mockGetAllThrowsException();

        await expectLater(repository.initFeatureFlags(), throwsException);
      });

      test(
          'should throw exception '
          'when putting in cache throw exception', () async {
        const featureFlags = [
          FeatureFlag(Feature.contactUsHomeFab, false),
          FeatureFlag(Feature.languageSwitcher, true),
        ];
        mockFeatureFlagCache.mockGetAll([]);
        mockFeatureFlagRepository.mockInitFeatureFlags();
        mockFeatureFlagRepository.mockGetFeatureFlags(featureFlags);

        mockFeatureFlagCache.mockPutThrowsException();

        await expectLater(repository.initFeatureFlags(), throwsException);
      });

      test(
          'should throw exception '
          'when delegate repository throw exception', () async {
        const featureFlags = [
          FeatureFlag(Feature.contactUsHomeFab, false),
          FeatureFlag(Feature.languageSwitcher, true),
        ];
        mockFeatureFlagCache.mockGetAll([]);
        mockFeatureFlagRepository.mockInitFeatureFlagsException();
        mockFeatureFlagRepository.mockGetFeatureFlags(featureFlags);
        mockFeatureFlagCache.mockPut();

        await expectLater(repository.initFeatureFlags(), throwsException);
      });
    });

    group('getFeatureFlags', () {
      test('should return list of cached data', () async {
        final cachedList = [
          FeatureModel(name: 'contact_us_home_fab', isEnabled: 0),
        ];
        mockFeatureFlagCache.mockGetAll(cachedList);

        final result = await repository.getFeatureFlags();

        expect(
          result,
          const [FeatureFlag(Feature.contactUsHomeFab, false)],
        );
      });

      test('should skip invalid cached data', () async {
        final cachedList = [
          FeatureModel(name: 'invalid_key', isEnabled: 0),
        ];
        mockFeatureFlagCache.mockGetAll(cachedList);

        final result = await repository.getFeatureFlags();

        expect(result.isEmpty, isTrue);
      });

      test('should return empty when cached data is empty', () async {
        mockFeatureFlagCache.mockGetAll([]);

        final result = await repository.getFeatureFlags();

        expect(result.isEmpty, isTrue);
      });
    });

    group('isFeatureEnabled', () {
      test('should return value of cached Feature', () async {
        mockFeatureFlagCache.mockGet(
          FeatureModel(name: 'contact_us_home_fab', isEnabled: 1),
        );

        final result = await repository.isFeatureEnabled(
          Feature.contactUsHomeFab,
        );

        expect(result, isTrue);
      });

      test(
          'should return false value of cached Feature '
          'when not found in cache', () async {
        mockFeatureFlagCache.mockGet(null);

        final result = await repository.isFeatureEnabled(
          Feature.languageSwitcher,
        );

        expect(result, isFalse);
      });
    });

    group('reset', () {
      test('should delete cache and fill it', () async {
        const featureFlags = [
          FeatureFlag(Feature.contactUsHomeFab, false),
          FeatureFlag(Feature.languageSwitcher, true),
        ];

        mockFeatureFlagCache.mockDeleteAll();
        mockFeatureFlagCache.mockGetAll([]);
        mockFeatureFlagCache.mockPut();
        mockFeatureFlagRepository.mockInitFeatureFlags();
        mockFeatureFlagRepository.mockGetFeatureFlags(featureFlags);

        await repository.reset();

        verify(mockFeatureFlagCache.deleteAll).called(1);
        verify(mockFeatureFlagCache.getAll).called(1);
        verify(mockFeatureFlagRepository.initFeatureFlags).called(1);
        verify(mockFeatureFlagRepository.getFeatureFlags).called(1);
        verify(
          () => mockFeatureFlagCache.put(any()),
        ).called(featureFlags.length);
      });
    });

    group('updateFeatureFlag', () {
      test('should update the feature value in cache', () {
        mockFeatureFlagCache.mockPut();
        const featureFlag = FeatureFlag(Feature.contactUsHomeFab, false);

        repository.updateFeatureFlag(featureFlag);

        verify(
          () => mockFeatureFlagCache.put(any()),
        ).called(1);
      });
    });
  });
}
