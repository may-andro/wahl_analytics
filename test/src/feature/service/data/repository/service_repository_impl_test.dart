import 'package:core/core.dart';
import 'package:firebase/firebase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wahl_analytics/src/feature/service/data/data.dart';
import 'package:wahl_analytics/src/feature/service/domain/domain.dart';

import '../../../../../mock/firebase/mock_fb_firestore_controller.dart';

void main() {
  group(ServiceRepositoryImpl, () {
    late ServiceRepositoryImpl repository;

    late AppLocale appLocale;
    late BuildConfig buildConfig;
    late MockFbFirestoreController mockFbFirestoreController;
    late BusinessServiceMapper businessServiceMapper;
    late AllLocaleBusinessServiceMapper allLocaleBusinessServiceMapper;

    final Map<String, dynamic> testServiceData = {
      'en': {
        'name': 'name',
        'title': 'English',
        'shortDescription': 'description',
        'action': 'action',
        'services': [
          {
            'icon': 'icon',
            'title': 'title',
            'shortDescription': 'shortDescription',
            'longDescription': 'longDescription',
          },
        ],
      },
      'es': {
        'name': 'name',
        'title': 'Spanish',
        'shortDescription': 'description',
        'action': 'action',
        'services': [
          {
            'icon': 'icon',
            'title': 'title',
            'shortDescription': 'shortDescription',
            'longDescription': 'longDescription',
          },
        ],
      },
      'nl': {
        'name': 'name',
        'title': 'Dutch',
        'shortDescription': 'description',
        'action': 'action',
        'services': [
          {
            'icon': 'icon',
            'title': 'title',
            'shortDescription': 'shortDescription',
            'longDescription': 'longDescription',
          },
        ],
      },
    };

    setUp(() {
      appLocale = AppLocale('en');
      buildConfig = BuildConfig(buildEnvironment: BuildEnvironment.staging);
      mockFbFirestoreController = MockFbFirestoreController();
      businessServiceMapper = BusinessServiceMapper(ServiceMapper());
      allLocaleBusinessServiceMapper = AllLocaleBusinessServiceMapper(
        businessServiceMapper,
      );

      repository = ServiceRepositoryImpl(
        appLocale,
        buildConfig,
        mockFbFirestoreController,
        businessServiceMapper,
        allLocaleBusinessServiceMapper,
      );
    });

    group('getBusinessService', () {
      test(
        'should return $AllLocaleBusinessServiceEntity '
        'when firebase has valid data',
        () async {
          mockFbFirestoreController
              .mockGetDocumentFromCollection(testServiceData);

          final result = await repository.getBusinessService();

          expect(result, isA<AllLocaleBusinessServiceEntity>());
        },
      );

      test(
        'should throw $NullDataFoundServiceException '
        'when firebase has null data',
        () {
          mockFbFirestoreController.mockGetDocumentFromCollection(null);

          expect(
            () async => await repository.getBusinessService(),
            throwsA(
              predicate(
                (exception) => exception is NullDataFoundServiceException,
              ),
            ),
          );
        },
      );

      test(
        'should throw $ServerServiceException '
        'when firebase has $FirestoreException exception',
        () {
          final exception = FirestoreException(
            Exception(),
            StackTrace.current,
          );
          mockFbFirestoreController
              .mockGetDocumentFromCollectionThrowsException(exception);

          expect(
            () async => await repository.getBusinessService(),
            throwsA(
              predicate((exception) => exception is ServerServiceException),
            ),
          );
        },
      );

      test(
        'should throw $IncorrectJsonServiceException '
        'when json is different from expected',
        () {
          mockFbFirestoreController.mockGetDocumentFromCollection(
            {
              'test': {
                'name': 'name',
                'title': 'title',
              },
            },
          );

          expect(
            () async => await repository.getBusinessService(),
            throwsA(
              predicate(
                (exception) => exception is IncorrectJsonServiceException,
              ),
            ),
          );
        },
      );

      test(
        'should throw $UnknownServiceException '
        'when json is different from expected',
        () {
          final exception = Exception();
          mockFbFirestoreController
              .mockGetDocumentFromCollectionThrowsException(exception);

          expect(
            () async => await repository.getBusinessService(),
            throwsA(
              predicate(
                (exception) => exception is UnknownServiceException,
              ),
            ),
          );
        },
      );
    });

    group('getBusinessServiceForLocale', () {
      test(
        'should return BusinessServiceEntity '
        'when firebase has valid data',
        () async {
          mockFbFirestoreController
              .mockGetDocumentFromCollection(testServiceData);

          final result = await repository.getBusinessServiceForLocale();

          expect(result, isA<BusinessServiceEntity>());
          expect(result.title, 'English');
        },
      );

      test(
        'should throw NullDataFoundServiceException '
        'when firebase has null data',
        () {
          mockFbFirestoreController.mockGetDocumentFromCollection(null);

          expect(
            () async => await repository.getBusinessService(),
            throwsA(
              predicate(
                (exception) => exception is NullDataFoundServiceException,
              ),
            ),
          );
        },
      );

      test(
        'should throw ServerServiceException '
        'when firebase has FirestoreException exception',
        () {
          final exception = FirestoreException(
            Exception(),
            StackTrace.current,
          );
          mockFbFirestoreController
              .mockGetDocumentFromCollectionThrowsException(exception);

          expect(
            () async => await repository.getBusinessService(),
            throwsA(
              predicate((exception) => exception is ServerServiceException),
            ),
          );
        },
      );

      test(
        'should throw IncorrectJsonServiceException '
        'when json is different from expected',
        () {
          mockFbFirestoreController.mockGetDocumentFromCollection(
            {
              'test': {
                'name': 'name',
                'title': 'title',
              },
            },
          );

          expect(
            () async => await repository.getBusinessService(),
            throwsA(
              predicate(
                (exception) => exception is IncorrectJsonServiceException,
              ),
            ),
          );
        },
      );

      test(
        'should throw UnknownServiceException '
        'when json is different from expected',
        () {
          final exception = Exception();
          mockFbFirestoreController
              .mockGetDocumentFromCollectionThrowsException(exception);

          expect(
            () async => await repository.getBusinessService(),
            throwsA(
              predicate(
                (exception) => exception is UnknownServiceException,
              ),
            ),
          );
        },
      );
    });

    group('updateAllLocaleBusinessService', () {
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

      test(
        'should call $FbFirestoreController when firebase has valid data',
        () async {
          mockFbFirestoreController.mockUpdateDocumentFromCollection();

          await repository.updateAllLocaleBusinessService(
            allLocaleBusinessServiceEntity,
          );

          verify(
            () => mockFbFirestoreController.updateDocumentFromCollection(
              any(),
              any(),
              any(),
            ),
          ).called(1);
        },
      );

      test(
        'should throw $ServerServiceException '
        'when firebase has $FirestoreException exception',
        () {
          final exception = FirestoreException(
            Exception(),
            StackTrace.current,
          );
          mockFbFirestoreController
              .mockUpdateDocumentFromCollectionThrowsException(exception);

          expect(
            () async => await repository.updateAllLocaleBusinessService(
              allLocaleBusinessServiceEntity,
            ),
            throwsA(
              predicate((exception) => exception is ServerServiceException),
            ),
          );
        },
      );

      test(
        'should throw $UnknownServiceException '
        'when unexpected exception occurs',
        () {
          final exception = Exception();
          mockFbFirestoreController
              .mockGetDocumentFromCollectionThrowsException(exception);

          expect(
            () async => await repository
                .updateAllLocaleBusinessService(allLocaleBusinessServiceEntity),
            throwsA(
              predicate(
                (exception) => exception is UnknownServiceException,
              ),
            ),
          );
        },
      );
    });
  });
}
