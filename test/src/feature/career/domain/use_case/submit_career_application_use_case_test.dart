import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wahl_analytics/src/feature/career/domain/domain.dart';

import '../../../../../mock/src/feature/career/domain/repository/mock_career_repository.dart';

void main() {
  group(SubmitCareerApplicationUseCase, () {
    late SubmitCareerApplicationUseCase useCase;

    late MockCareerRepository mockCareerRepository;

    setUpAll(() {
      registerFallbackValue(Uint8List.fromList([0, 1, 2, 3]));
      registerFallbackValue(CareerApplicationEntity.test());
    });

    setUp(() {
      mockCareerRepository = MockCareerRepository();

      useCase = SubmitCareerApplicationUseCase(mockCareerRepository);
    });

    test('should call repository to submit the application', () async {
      mockCareerRepository.mockSubmitCareerApplication();

      final result = await useCase(CareerApplicationEntity.test());

      expect(result.isRight, isTrue);
    });

    test(
        'should return $ApplicationUploadFailure '
        'when document is failed to upload', () async {
      mockCareerRepository.mockSubmitCareerApplicationThrowsException(
        UploadDocumentFailureException(Exception(), StackTrace.current),
      );

      final result = await useCase(CareerApplicationEntity.test());

      expect(result.isLeft, isTrue);
      expect(result.left, isA<ApplicationUploadFailure>());
    });

    test(
        'should return $ApplicationSubmissionFailure '
        'when UnknownCareerException thrown', () async {
      mockCareerRepository.mockSubmitCareerApplicationThrowsException(
        UnknownCareerException(Exception(), StackTrace.current),
      );

      final result = await useCase(CareerApplicationEntity.test());

      expect(result.isLeft, isTrue);
      expect(result.left, isA<ApplicationSubmissionFailure>());
    });

    test(
        'should return $ApplicationSubmissionUnknownFailure '
        'when unknown exception occurs', () async {
      mockCareerRepository.mockSubmitCareerApplicationThrowsException(
        Exception(),
      );

      final result = await useCase(CareerApplicationEntity.test());

      expect(result.isLeft, isTrue);
      expect(result.left, isA<ApplicationSubmissionUnknownFailure>());
    });
  });
}
