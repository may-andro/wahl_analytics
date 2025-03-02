import 'package:flutter_test/flutter_test.dart';
import 'package:wahl_analytics/src/feature/service/domain/domain.dart';

import '../../../../../mock/src/feature/service/domain/repository/mock_service_repository.dart';

void main() {
  group(GetBusinessServiceUseCase, () {
    late GetBusinessServiceUseCase useCase;

    late MockServiceRepository mockServiceRepository;

    setUp(() {
      mockServiceRepository = MockServiceRepository();

      useCase = GetBusinessServiceUseCase(mockServiceRepository);
    });

    test(
      'should return business service entity',
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

        mockServiceRepository.mockGetBusinessServiceForLocale(
          businessServiceEntity,
        );

        final result = await useCase();

        expect(result.isRight, isTrue);
        expect(result.right, businessServiceEntity);
      },
    );

    test(
      'should return $BusinessServiceFailure '
      'when exception is thrown',
      () async {
        final exceptions = [
          NullDataFoundServiceException(Exception(), StackTrace.current),
          ServerServiceException(Exception(), StackTrace.current),
          IncorrectJsonServiceException(Exception(), StackTrace.current),
          UnknownServiceException(Exception(), StackTrace.current),
        ];

        for (final exception in exceptions) {
          mockServiceRepository.mockGetBusinessServiceThrowsException(
            exception,
          );
        }

        mockServiceRepository.mockGetBusinessServiceThrowsException(
          NullDataFoundServiceException(Exception(), StackTrace.current),
        );

        final result = await useCase();

        expect(result.isLeft, isTrue);
        expect(result.left, isA<BusinessServiceFailure>());
      },
    );
  });
}
