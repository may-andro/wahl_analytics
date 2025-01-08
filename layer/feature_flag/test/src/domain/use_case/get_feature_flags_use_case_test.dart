import 'package:feature_flag/src/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:use_case/use_case.dart';

import '../../../_mock/src/domain/mock_feature_flag_repository.dart';

void main() {
  group('GetFeatureFlagsUseCase', () {
    late GetFeatureFlagsUseCase useCase;

    late MockFeatureFlagRepository mockFeatureFlagRepository;

    setUp(() {
      mockFeatureFlagRepository = MockFeatureFlagRepository();

      useCase = GetFeatureFlagsUseCase(mockFeatureFlagRepository);
    });

    group('call', () {
      test('should return map when cache is present', () async {
        const expected = [FeatureFlag(Feature.contactUsHomeFab, true)];
        mockFeatureFlagRepository.mockGetFeatureFlags(expected);

        final result = await useCase();

        expect(result.isRight, true);
        expect(result.right, isA<List<FeatureFlag>>());
        expect(result.right, expected);
      });

      test('should return $Left when there is error', () async {
        mockFeatureFlagRepository.mockGetFeatureFlagsException();

        final result = await useCase();

        expect(result.isLeft, true);
        expect(result.left, isA<FeatureFlagFetchFailure>());
      });
    });
  });
}
