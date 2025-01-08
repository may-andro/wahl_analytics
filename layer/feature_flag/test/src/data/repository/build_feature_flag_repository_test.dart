import 'package:core/core.dart';
import 'package:feature_flag/src/data/repository/build_feature_flag_repository.dart';
import 'package:feature_flag/src/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_mock/src/domain/mock_feature_flag_repository.dart';

class MockBuildConfig extends Mock implements BuildConfig {
  void mockBuildEnvironment(BuildEnvironment expected) {
    when(() => buildEnvironment).thenReturn(expected);
  }
}

void main() {
  group('BuildFeatureFlagRepository', () {
    late BuildFeatureFlagRepository repository;

    late MockBuildConfig mockBuildConfig;
    late MockFeatureFlagRepository delegateCache;
    late MockFeatureFlagRepository delegateRemote;

    setUp(() {
      mockBuildConfig = MockBuildConfig();
      delegateCache = MockFeatureFlagRepository();
      delegateRemote = MockFeatureFlagRepository();
    });

    setUpAll(() {
      registerFallbackValue(Feature.contactUsHomeFab);
    });

    group('initFeatureFlags', () {
      test('should call delegateCache when BuildEnvironment is staging', () {
        mockBuildConfig.mockBuildEnvironment(BuildEnvironment.staging);
        repository = BuildFeatureFlagRepository(
          mockBuildConfig,
          delegateCache,
          delegateRemote,
        );

        repository.initFeatureFlags();

        verify(delegateCache.initFeatureFlags).called(1);
        verifyNever(() => delegateRemote.initFeatureFlags());
      });

      test('should call delegateRemote when BuildEnvironment is prod', () {
        mockBuildConfig.mockBuildEnvironment(BuildEnvironment.prod);
        repository = BuildFeatureFlagRepository(
          mockBuildConfig,
          delegateCache,
          delegateRemote,
        );

        repository.initFeatureFlags();

        verify(delegateRemote.initFeatureFlags).called(1);
        verifyNever(() => delegateCache.initFeatureFlags());
      });
    });

    group('isFeatureEnabled', () {
      test('should call delegateCache when BuildEnvironment is staging', () {
        mockBuildConfig.mockBuildEnvironment(BuildEnvironment.staging);
        delegateCache.mockIsFeatureEnabled(true);
        delegateRemote.mockIsFeatureEnabled(true);
        const feature = Feature.languageSwitcher;
        repository = BuildFeatureFlagRepository(
          mockBuildConfig,
          delegateCache,
          delegateRemote,
        );

        repository.isFeatureEnabled(feature);

        verify(() => delegateCache.isFeatureEnabled(feature)).called(1);
        verifyNever(() => delegateRemote.isFeatureEnabled(feature));
      });

      test('should call delegateRemote when BuildEnvironment is prod', () {
        mockBuildConfig.mockBuildEnvironment(BuildEnvironment.prod);
        delegateCache.mockIsFeatureEnabled(true);
        delegateRemote.mockIsFeatureEnabled(true);
        const feature = Feature.languageSwitcher;
        repository = BuildFeatureFlagRepository(
          mockBuildConfig,
          delegateCache,
          delegateRemote,
        );

        repository.isFeatureEnabled(feature);

        verify(() => delegateRemote.isFeatureEnabled(feature)).called(1);
        verifyNever(() => delegateCache.isFeatureEnabled(feature));
      });
    });

    group('getFeatureFlags', () {
      test('should call delegateCache when BuildEnvironment is staging', () {
        delegateCache.mockGetFeatureFlags([]);
        delegateRemote.mockGetFeatureFlags([]);
        mockBuildConfig.mockBuildEnvironment(BuildEnvironment.staging);
        repository = BuildFeatureFlagRepository(
          mockBuildConfig,
          delegateCache,
          delegateRemote,
        );

        repository.getFeatureFlags();

        verify(delegateCache.getFeatureFlags).called(1);
        verifyNever(delegateRemote.getFeatureFlags);
      });

      test('should call delegateRemote when BuildEnvironment is prod', () {
        delegateCache.mockGetFeatureFlags([]);
        delegateRemote.mockGetFeatureFlags([]);
        mockBuildConfig.mockBuildEnvironment(BuildEnvironment.prod);
        repository = BuildFeatureFlagRepository(
          mockBuildConfig,
          delegateCache,
          delegateRemote,
        );

        repository.getFeatureFlags();

        verify(delegateRemote.getFeatureFlags).called(1);
        verifyNever(delegateCache.getFeatureFlags);
      });
    });

    group('reset', () {
      test('should call delegateCache when BuildEnvironment is staging', () {
        mockBuildConfig.mockBuildEnvironment(BuildEnvironment.staging);
        repository = BuildFeatureFlagRepository(
          mockBuildConfig,
          delegateCache,
          delegateRemote,
        );

        repository.reset();

        verify(delegateCache.reset).called(1);
        verifyNever(delegateRemote.reset);
      });

      test('should call delegateRemote when BuildEnvironment is prod', () {
        mockBuildConfig.mockBuildEnvironment(BuildEnvironment.prod);
        repository = BuildFeatureFlagRepository(
          mockBuildConfig,
          delegateCache,
          delegateRemote,
        );

        repository.reset();

        verify(delegateRemote.reset).called(1);
        verifyNever(delegateCache.reset);
      });
    });

    group('updateFeatureFlag', () {
      test('should call delegateCache when BuildEnvironment is staging', () {
        mockBuildConfig.mockBuildEnvironment(BuildEnvironment.staging);
        const feature = FeatureFlag(Feature.languageSwitcher, true);
        repository = BuildFeatureFlagRepository(
          mockBuildConfig,
          delegateCache,
          delegateRemote,
        );

        repository.updateFeatureFlag(feature);

        verify(() => delegateCache.updateFeatureFlag(feature)).called(1);
        verifyNever(() => delegateRemote.updateFeatureFlag(feature));
      });

      test('should call delegateRemote when BuildEnvironment is prod', () {
        mockBuildConfig.mockBuildEnvironment(BuildEnvironment.prod);
        const feature = FeatureFlag(Feature.languageSwitcher, true);
        repository = BuildFeatureFlagRepository(
          mockBuildConfig,
          delegateCache,
          delegateRemote,
        );

        repository.updateFeatureFlag(feature);

        verify(() => delegateRemote.updateFeatureFlag(feature)).called(1);
        verifyNever(() => delegateCache.updateFeatureFlag(feature));
      });
    });
  });
}
