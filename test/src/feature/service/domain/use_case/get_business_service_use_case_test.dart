import 'package:flutter_test/flutter_test.dart';
import 'package:wahl_analytics/src/feature/service/domain/domain.dart';

import '../../../../../mock/src/feature/service/domain/repository/mock_service_repository.dart';

void main() {
  group('GetBusinessServiceUseCase', () {
    late GetBusinessServiceUseCase useCase;

    late MockServiceRepository mockServiceRepository;

    setUp(() {
      mockServiceRepository = MockServiceRepository();

      useCase = GetBusinessServiceUseCase(mockServiceRepository);
    });

    test(
      'should return business team',
      () async {
        const businessServiceEntity = BusinessServiceEntity(
          title: 'title',
          name: 'name',
          description: 'description',
          action: 'action',
          services: [
            ServiceEntity(
              icon: 'icon',
              shortDescription: 'shortDescription',
              longDescription: 'longDescription',
              title: 'title',
            ),
          ],
        );

        mockServiceRepository.mockGetBusinessService(businessServiceEntity);

        final result = await useCase();

        expect(result.isRight, isTrue);
        expect(result.right, businessServiceEntity);
      },
    );

    test(
      'should return BusinessServiceFailure '
      'when NullDataFoundServiceException is thrown',
      () async {
        mockServiceRepository.mockGetBusinessServiceThrowsException(
          NullDataFoundServiceException(Exception(), StackTrace.current),
        );

        final result = await useCase();

        expect(result.isLeft, isTrue);
        expect(result.left, isA<BusinessServiceFailure>());
      },
    );

    test(
      'should return BusinessServiceFailure '
      'when ServerServiceException thrown',
      () async {
        mockServiceRepository.mockGetBusinessServiceThrowsException(
          ServerServiceException(Exception(), StackTrace.current),
        );

        final result = await useCase();

        expect(result.isLeft, isTrue);
        expect(result.left, isA<BusinessServiceFailure>());
      },
    );

    test(
      'should return BusinessServiceFailure '
      'when IncorrectJsonServiceException thrown',
      () async {
        mockServiceRepository.mockGetBusinessServiceThrowsException(
          IncorrectJsonServiceException(Exception(), StackTrace.current),
        );

        final result = await useCase();

        expect(result.isLeft, isTrue);
        expect(result.left, isA<BusinessServiceFailure>());
      },
    );

    test(
      'should return BusinessServiceFailure '
      'when UnknownServiceException thrown',
      () async {
        mockServiceRepository.mockGetBusinessServiceThrowsException(
          UnknownServiceException(Exception(), StackTrace.current),
        );

        final result = await useCase();

        expect(result.isLeft, isTrue);
        expect(result.left, isA<BusinessServiceFailure>());
      },
    );
  });
}
