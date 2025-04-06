import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wahl_analytics/src/feature/career/domain/entity/career_entity.dart';
import 'package:wahl_analytics/src/feature/career/domain/use_case/delete_career_request_use_case.dart';

import '../../../../../mock/src/feature/career/domain/repository/mock_career_repository.dart';

void main() {
  group(DeleteCareerRequestUseCase, () {
    late DeleteCareerRequestUseCase useCase;

    late MockCareerRepository mockCareerRepository;

    setUpAll(() {
      registerFallbackValue(CareerEntity.test());
    });

    setUp(() {
      mockCareerRepository = MockCareerRepository();

      useCase = DeleteCareerRequestUseCase(mockCareerRepository);
    });

    test('should call repository to delete the career application', () async {
      mockCareerRepository.mockDeleteCareerRequest();

      final result = await useCase(CareerEntity.test());

      expect(result.isRight, isTrue);
    });

    test(
        'should return $DeleteCareerRequestFailure '
        'when exception occurs', () async {
      mockCareerRepository.mockGetCareersRequestThrowsException(Exception());

      final result = await useCase(CareerEntity.test());

      expect(result.isLeft, isTrue);
      expect(result.left, isA<DeleteCareerRequestFailure>());
    });
  });
}
