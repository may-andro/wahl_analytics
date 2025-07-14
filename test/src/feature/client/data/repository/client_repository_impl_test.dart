import 'package:core/core.dart';
import 'package:firebase/firebase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wahl_analytics/src/feature/client/data/data.dart';
import 'package:wahl_analytics/src/feature/client/domain/domain.dart';
import 'package:wahl_analytics/src/feature/service/service.dart';

import '../../../../../mock/firebase/mock_fb_firestore_controller.dart';

void main() {
  group('ClientRepositoryImpl', () {
    late ClientRepositoryImpl repository;

    late AppLocale appLocale;
    late BuildConfig buildConfig;
    late MockFbFirestoreController mockFbFirestoreController;
    late ServiceMapper serviceMapper;
    late ClientMapper clientMapper;
    late BusinessClientMapper businessClientMapper;

    final Map<String, dynamic> testClientData = {
      'en': {
        'name': 'name',
        'title': 'title',
        'shortDescription': 'shortDescription',
        'action': 'action',
        'clients': [
          {
            'url': 'url',
            'name': 'name',
            'shortDescription': 'shortDescription',
            'longDescription': 'longDescription',
            'servicesProvided': [
              {
                'icon': '0xf07f1',
                'title': 'title',
                'shortDescription': 'shortDescription',
                'longDescription': 'longDescription',
              },
            ],
          },
        ],
      },
    };

    const businessClientEntity = BusinessClientEntity(
      name: 'name',
      title: 'title',
      description: 'shortDescription',
      action: 'action',
      clients: [
        ClientEntity(
          url: 'url',
          name: 'name',
          shortDescription: 'shortDescription',
          longDescription: 'longDescription',
          services: [
            ServiceEntity(
              icon: '0xf07f1',
              title: 'title',
              shortDescription: 'shortDescription',
              longDescription: 'longDescription',
            ),
          ],
        ),
      ],
    );

    setUp(() {
      appLocale = AppLocale('en');
      buildConfig = BuildConfig(buildEnvironment: BuildEnvironment.staging);
      mockFbFirestoreController = MockFbFirestoreController();
      serviceMapper = ServiceMapper();
      clientMapper = ClientMapper(serviceMapper);
      businessClientMapper = BusinessClientMapper(clientMapper);

      repository = ClientRepositoryImpl(
        appLocale,
        buildConfig,
        mockFbFirestoreController,
        businessClientMapper,
      );
    });

    group('getBusinessClient', () {
      test('should return BusinessClientEntity '
          'when firebase has valid data', () async {
        mockFbFirestoreController.mockGetDocumentFromCollection(testClientData);

        final result = await repository.getBusinessClient();

        expect(result, businessClientEntity);
      });

      test('should throw NullDataFoundClientException '
          'when firebase has null data', () {
        mockFbFirestoreController.mockGetDocumentFromCollection(null);

        expect(
          () async => await repository.getBusinessClient(),
          throwsA(
            predicate((exception) => exception is NullDataFoundClientException),
          ),
        );
      });

      test('should throw ServerClientException '
          'when firebase has FirestoreException exception', () {
        final exception = FirestoreException(Exception(), StackTrace.current);
        mockFbFirestoreController.mockGetDocumentFromCollectionThrowsException(
          exception,
        );

        expect(
          () async => await repository.getBusinessClient(),
          throwsA(predicate((exception) => exception is ServerClientException)),
        );
      });

      test('should throw IncorrectJsonClientException '
          'when json is different from expected', () {
        mockFbFirestoreController.mockGetDocumentFromCollection({
          'test': {'name': 'name', 'title': 'title'},
        });

        expect(
          () async => await repository.getBusinessClient(),
          throwsA(
            predicate((exception) => exception is IncorrectJsonClientException),
          ),
        );
      });

      test('should throw UnknownClientException '
          'when json is different from expected', () {
        final exception = Exception();
        mockFbFirestoreController.mockGetDocumentFromCollectionThrowsException(
          exception,
        );

        expect(
          () async => await repository.getBusinessClient(),
          throwsA(
            predicate((exception) => exception is UnknownClientException),
          ),
        );
      });
    });
  });
}
