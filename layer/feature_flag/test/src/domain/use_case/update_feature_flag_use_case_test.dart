import 'package:feature_flag/src/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:use_case/use_case.dart';

import '../../../_mock/src/domain/mock_feature_flag_repository.dart';

void main() {
  group(UpdateFeatureFlagUseCase, () {
    late UpdateFeatureFlagUseCase useCase;

    late MockFeatureFlagRepository mockFeatureFlagRepository;

    setUpAll(() {
      registerFallbackValue(const FeatureFlag(Feature.contactUsHomeFab, true));
    });

    setUp(() {
      mockFeatureFlagRepository = MockFeatureFlagRepository();

      useCase = UpdateFeatureFlagUseCase(mockFeatureFlagRepository);

      mockFeatureFlagRepository.mockUpdateFeatureFlag();
    });

    test('should return $Right when there is no error', () async {
      mockFeatureFlagRepository.mockUpdateFeatureFlag();

      final result = await useCase(
        const FeatureFlag(Feature.contactUsHomeFab, true),
      );

      expect(result.isRight, true);
      verify(
        () => mockFeatureFlagRepository.updateFeatureFlag(any()),
      ).called(1);
    });

    test('should return $Left when there is no error', () async {
      mockFeatureFlagRepository.mockUpdateFeatureFlagException();

      final result = await useCase(
        const FeatureFlag(Feature.contactUsHomeFab, true),
      );

      expect(result.isLeft, true);
      verify(
        () => mockFeatureFlagRepository.updateFeatureFlag(any()),
      ).called(1);
    });
  });
}
