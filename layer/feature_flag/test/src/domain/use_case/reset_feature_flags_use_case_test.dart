import 'package:feature_flag/src/domain/use_case/reset_feature_flags_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:use_case/use_case.dart';

import '../../../_mock/src/domain/mock_feature_flag_repository.dart';

void main() {
  group(ResetFeatureFlagsUseCase, () {
    late ResetFeatureFlagsUseCase useCase;

    late MockFeatureFlagRepository mockFeatureFlagRepository;

    setUp(() {
      mockFeatureFlagRepository = MockFeatureFlagRepository();

      useCase = ResetFeatureFlagsUseCase(mockFeatureFlagRepository);
    });

    test('should return $Right when there is no error', () async {
      mockFeatureFlagRepository.mockReset();

      final result = await useCase();

      expect(result.isRight, true);
      verify(() => mockFeatureFlagRepository.reset()).called(1);
    });

    test('should return $Left when there is no error', () async {
      mockFeatureFlagRepository.mockResetException();

      final result = await useCase();

      expect(result.isLeft, true);
      verify(() => mockFeatureFlagRepository.reset()).called(1);
    });
  });
}
