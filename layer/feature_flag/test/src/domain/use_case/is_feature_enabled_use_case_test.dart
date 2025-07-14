import 'package:feature_flag/src/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_mock/src/domain/mock_feature_flag_repository.dart';

void main() {
  group(IsFeatureEnabledUseCase, () {
    late MockFeatureFlagRepository mockFeatureFlagRepository;

    late IsFeatureEnabledUseCase useCase;

    setUpAll(() {
      registerFallbackValue(Feature.contactUsHomeFab);
    });

    setUp(() {
      mockFeatureFlagRepository = MockFeatureFlagRepository();

      useCase = IsFeatureEnabledUseCase(mockFeatureFlagRepository);
    });

    test('should return Right when there is no error', () async {
      mockFeatureFlagRepository.mockIsFeatureEnabled(true);

      final result = await useCase(Feature.contactUsHomeFab);

      expect(result.isRight, true);
      expect(result.right, true);
      verify(() => mockFeatureFlagRepository.isFeatureEnabled(any())).called(1);
    });

    test('should return Left when there is error', () async {
      mockFeatureFlagRepository.mockIsFeatureEnabledException();

      final result = await useCase(Feature.contactUsHomeFab);

      expect(result.isLeft, true);
      verify(() => mockFeatureFlagRepository.isFeatureEnabled(any())).called(1);
    });
  });
}
