import 'package:core/core.dart';
import 'package:firebase/firebase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wahl_analytics/src/feature/service/data/data.dart';
import 'package:wahl_analytics/src/feature/service/domain/domain.dart';

import '../../../../../mock/firebase/mock_fb_firestore_controller.dart';

void main() {
  group('ServiceRepositoryImpl', () {
    late ServiceRepositoryImpl repository;

    late AppLocale appLocale;
    late BuildConfig buildConfig;
    late MockFbFirestoreController mockFbFirestoreController;
    late BusinessServiceMapper businessServiceMapper;

    final Map<String, dynamic> testServiceData = {
      'en': {
        'name': 'name',
        'title': 'title',
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

    setUp(() {
      appLocale = AppLocale('en');
      buildConfig = BuildConfig(buildEnvironment: BuildEnvironment.staging);
      mockFbFirestoreController = MockFbFirestoreController();
      businessServiceMapper = BusinessServiceMapper(ServiceMapper());

      repository = ServiceRepositoryImpl(
        appLocale,
        buildConfig,
        mockFbFirestoreController,
        businessServiceMapper,
      );
    });

    group('getBusinessService', () {
      test(
        'should return BusinessServiceEntity '
        'when firebase has valid data',
        () async {
          mockFbFirestoreController
              .mockGetDocumentFromCollection(testServiceData);

          final result = await repository.getBusinessService();

          expect(result, businessServiceEntity);
        },
      );

      test(
        'should throw NullDataFoundServiceException '
        'when firebase has null data',
        () async {
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
        () async {
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
        () async {
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
        () async {
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
  });
}
