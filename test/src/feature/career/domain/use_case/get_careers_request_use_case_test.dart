import 'package:flutter_test/flutter_test.dart';
import 'package:wahl_analytics/src/feature/career/domain/entity/career_entity.dart';
import 'package:wahl_analytics/src/feature/career/domain/use_case/get_careers_request_use_case.dart';

import '../../../../../mock/src/feature/career/domain/repository/mock_career_repository.dart';

void main() {
  group(GetCareersRequestUseCase, () {
    late GetCareersRequestUseCase useCase;

    late MockCareerRepository mockCareerRepository;

    final careers = [CareerEntity.test()];

    setUp(() {
      mockCareerRepository = MockCareerRepository();

      useCase = GetCareersRequestUseCase(mockCareerRepository);
    });

    test('should call repository to get the career applications', () async {
      mockCareerRepository.mockGetCareersRequest(careers);

      final result = await useCase();

      expect(result.isRight, isTrue);
      expect(result.right.length, careers.length);
    });

    test('should return $GetCareersRequestFailure '
        'when exception occurs', () async {
      mockCareerRepository.mockGetCareersRequestThrowsException(Exception());

      final result = await useCase();

      expect(result.isLeft, isTrue);
      expect(result.left, isA<GetCareersRequestFailure>());
    });
  });
}
