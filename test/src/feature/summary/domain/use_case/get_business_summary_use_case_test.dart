import 'package:flutter_test/flutter_test.dart';
import 'package:wahl_analytics/src/feature/summary/domain/domain.dart';

import '../../../../../mock/src/feature/summary/domain/repository/mock_summary_repository.dart';

void main() {
  group('GetBusinessSummaryUseCase', () {
    late GetBusinessSummaryUseCase useCase;

    late MockSummaryRepository mockSummaryRepository;

    setUp(() {
      mockSummaryRepository = MockSummaryRepository();

      useCase = GetBusinessSummaryUseCase(mockSummaryRepository);
    });

    test('should return business team', () async {
      const businessSummaryEntity = BusinessSummaryEntity(
        title: 'url',
        urls: ['url'],
        descriptions: ['description'],
      );
      mockSummaryRepository.mockGetBusinessSummary(businessSummaryEntity);

      final result = await useCase();

      expect(result.isRight, isTrue);
      expect(result.right, businessSummaryEntity);
    });

    test('should return BusinessSummaryFailure '
        'when NullDataFoundSummaryException is thrown', () async {
      mockSummaryRepository.mockGetBusinessSummaryThrowsException(
        NullDataFoundSummaryException(Exception(), StackTrace.current),
      );

      final result = await useCase();

      expect(result.isLeft, isTrue);
      expect(result.left, isA<BusinessSummaryFailure>());
    });

    test('should return BusinessSummaryFailure '
        'when ServerSummaryException thrown', () async {
      mockSummaryRepository.mockGetBusinessSummaryThrowsException(
        ServerSummaryException(Exception(), StackTrace.current),
      );

      final result = await useCase();

      expect(result.isLeft, isTrue);
      expect(result.left, isA<BusinessSummaryFailure>());
    });

    test('should return BusinessSummaryFailure '
        'when IncorrectJsonSummaryException thrown', () async {
      mockSummaryRepository.mockGetBusinessSummaryThrowsException(
        IncorrectJsonSummaryException(Exception(), StackTrace.current),
      );

      final result = await useCase();

      expect(result.isLeft, isTrue);
      expect(result.left, isA<BusinessSummaryFailure>());
    });

    test('should return BusinessSummaryFailure '
        'when UnknownSummaryException thrown', () async {
      mockSummaryRepository.mockGetBusinessSummaryThrowsException(
        UnknownSummaryException(Exception(), StackTrace.current),
      );

      final result = await useCase();

      expect(result.isLeft, isTrue);
      expect(result.left, isA<BusinessSummaryFailure>());
    });
  });
}
