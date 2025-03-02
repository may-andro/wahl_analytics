import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wahl_analytics/src/feature/service/domain/domain.dart';

import '../../../../../mock/src/feature/service/domain/repository/mock_service_repository.dart';

void main() {
  group(UpdateAllLocaleBusinessServiceUseCase, () {
    late UpdateAllLocaleBusinessServiceUseCase useCase;

    late MockServiceRepository mockServiceRepository;

    const allLocaleBusinessServiceEntity = AllLocaleBusinessServiceEntity(
      en: BusinessServiceEntity(
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
      ),
      es: BusinessServiceEntity(
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
      ),
      nl: BusinessServiceEntity(
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
      ),
    );

    setUpAll(() {
      registerFallbackValue(allLocaleBusinessServiceEntity);
    });

    setUp(() {
      mockServiceRepository = MockServiceRepository();

      useCase = UpdateAllLocaleBusinessServiceUseCase(mockServiceRepository);
    });

    test(
      'should call $ServiceRepository to update the data',
      () async {
        await useCase(allLocaleBusinessServiceEntity);

        verify(
          () => mockServiceRepository.updateAllLocaleBusinessService(
            allLocaleBusinessServiceEntity,
          ),
        ).called(1);
      },
    );

    test(
      'should return $UpdateAllLocaleBusinessServiceFailure '
      'when $Exception is thrown',
      () async {
        mockServiceRepository.mockUpdateAllLocaleBusinessServiceThrowsException(
          Exception(),
        );

        final result = await useCase(allLocaleBusinessServiceEntity);

        expect(result.isLeft, isTrue);
        expect(result.left, isA<UpdateAllLocaleBusinessServiceFailure>());
      },
    );
  });
}
