import 'package:flutter_test/flutter_test.dart';
import 'package:wahl_analytics/src/feature/client/domain/domain.dart';
import 'package:wahl_analytics/src/feature/service/service.dart';

import '../../../../../mock/src/feature/client/domain/repository/mock_client_repository.dart';

void main() {
  group('GetBusinessClientUseCase', () {
    late GetBusinessClientUseCase useCase;

    late MockClientRepository mockClientRepository;

    setUp(() {
      mockClientRepository = MockClientRepository();

      useCase = GetBusinessClientUseCase(mockClientRepository);
    });

    test(
      'should return business client',
      () async {
        const businessClientEntity = BusinessClientEntity(
          title: 'url',
          name: 'name',
          description: 'description',
          action: 'action',
          clients: [
            ClientEntity(
              url: 'url',
              name: 'name',
              shortDescription: 'shortDescription',
              longDescription: 'longDescription',
              services: [
                ServiceEntity(
                  icon: 'icon',
                  shortDescription: 'shortDescription',
                  longDescription: 'longDescription',
                  title: 'title',
                ),
              ],
            ),
          ],
        );
        mockClientRepository.mockGetBusinessClient(businessClientEntity);

        final result = await useCase();

        expect(result.isRight, isTrue);
        expect(result.right, businessClientEntity);
      },
    );

    test(
      'should return BusinessClientFailure '
      'when NullDataFoundClientException is thrown',
      () async {
        mockClientRepository.mockGetBusinessClientThrowsException(
          NullDataFoundClientException(Exception(), StackTrace.current),
        );

        final result = await useCase();

        expect(result.isLeft, isTrue);
        expect(result.left, isA<BusinessClientFailure>());
      },
    );

    test(
      'should return BusinessClientFailure '
      'when ServerClientException thrown',
      () async {
        mockClientRepository.mockGetBusinessClientThrowsException(
          ServerClientException(Exception(), StackTrace.current),
        );

        final result = await useCase();

        expect(result.isLeft, isTrue);
        expect(result.left, isA<BusinessClientFailure>());
      },
    );

    test(
      'should return BusinessClientFailure '
      'when IncorrectJsonClientException thrown',
      () async {
        mockClientRepository.mockGetBusinessClientThrowsException(
          IncorrectJsonClientException(Exception(), StackTrace.current),
        );

        final result = await useCase();

        expect(result.isLeft, isTrue);
        expect(result.left, isA<BusinessClientFailure>());
      },
    );

    test(
      'should return BusinessClientFailure '
      'when UnknownClientException thrown',
      () async {
        mockClientRepository.mockGetBusinessClientThrowsException(
          UnknownClientException(Exception(), StackTrace.current),
        );

        final result = await useCase();

        expect(result.isLeft, isTrue);
        expect(result.left, isA<BusinessClientFailure>());
      },
    );
  });
}
