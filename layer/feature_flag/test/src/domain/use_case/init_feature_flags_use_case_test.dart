import 'package:feature_flag/src/domain/use_case/init_feature_flags_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:use_case/use_case.dart';

import '../../../_mock/src/domain/mock_feature_flag_repository.dart';

void main() {
  group('InitFeatureFlagsUseCase', () {
    late InitFeatureFlagsUseCase useCase;

    late MockFeatureFlagRepository mockFeatureFlagRepository;

    setUp(() {
      mockFeatureFlagRepository = MockFeatureFlagRepository();

      useCase = InitFeatureFlagsUseCase(mockFeatureFlagRepository);
    });

    group('call', () {
      test('should call $Right when there is no error', () async {
        mockFeatureFlagRepository.mockInitFeatureFlags();

        final result = await useCase();

        expect(result.isRight, true);
        verify(() => mockFeatureFlagRepository.initFeatureFlags()).called(1);
      });

      test('should handle error when occur', () async {
        mockFeatureFlagRepository.mockInitFeatureFlagsException();

        final result = await useCase();

        expect(result.isLeft, true);
        verify(() => mockFeatureFlagRepository.initFeatureFlags()).called(1);
      });
    });
  });
}
