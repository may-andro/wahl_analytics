import 'package:core/core.dart';
import 'package:firebase/firebase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wahl_analytics/src/feature/contact/data/data.dart';
import 'package:wahl_analytics/src/feature/contact/domain/domain.dart';

import '../../../../../mock/firebase/mock_fb_firestore_controller.dart';

void main() {
  group('ContactRepositoryImpl', () {
    late ContactRepositoryImpl repository;

    late AppLocale appLocale;
    late BuildConfig buildConfig;
    late MockFbFirestoreController mockFbFirestoreController;
    late BusinessContactMapper businessContactMapper;
    late ContactUsMapper contactUsMapper;

    final Map<String, dynamic> testContactData = {
      'en': {
        'email': 'email',
        'mobileNumber': 'mobileNumber',
        'address': ['address1', 'address2'],
      },
    };

    const businessContactEntity = BusinessContactEntity(
      email: 'email',
      mobileNumber: 'mobileNumber',
      address: ['address1', 'address2'],
    );

    setUp(() {
      appLocale = AppLocale('en');
      buildConfig = BuildConfig(buildEnvironment: BuildEnvironment.staging);
      mockFbFirestoreController = MockFbFirestoreController();
      businessContactMapper = BusinessContactMapper();
      contactUsMapper = ContactUsMapper();

      repository = ContactRepositoryImpl(
        appLocale,
        buildConfig,
        mockFbFirestoreController,
        businessContactMapper,
        contactUsMapper,
      );
    });

    group('getBusinessContact', () {
      test(
        'should return BusinessContactEntity '
        'when firebase has valid data',
        () async {
          mockFbFirestoreController.mockGetDocumentFromCollection(
            testContactData,
          );

          final result = await repository.getBusinessContact();

          expect(result, businessContactEntity);
        },
      );

      test(
        'should throw NullDataFoundContactException '
        'when firebase has null data',
        () {
          mockFbFirestoreController.mockGetDocumentFromCollection(null);

          expect(
            () async => await repository.getBusinessContact(),
            throwsA(
              predicate(
                (exception) => exception is NullDataFoundContactException,
              ),
            ),
          );
        },
      );

      test(
        'should throw ServerContactException '
        'when firebase has FirestoreException exception',
        () {
          final exception = FirestoreException(
            Exception(),
            StackTrace.current,
          );
          mockFbFirestoreController
              .mockGetDocumentFromCollectionThrowsException(exception);

          expect(
            () async => await repository.getBusinessContact(),
            throwsA(
              predicate((exception) => exception is ServerContactException),
            ),
          );
        },
      );

      test(
        'should throw IncorrectJsonContactException '
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
            () async => await repository.getBusinessContact(),
            throwsA(
              predicate(
                (exception) => exception is IncorrectJsonContactException,
              ),
            ),
          );
        },
      );

      test(
        'should throw UnknownContactException '
        'when json is different from expected',
        () {
          final exception = Exception();
          mockFbFirestoreController
              .mockGetDocumentFromCollectionThrowsException(exception);

          expect(
            () async => await repository.getBusinessContact(),
            throwsA(
              predicate(
                (exception) => exception is UnknownContactException,
              ),
            ),
          );
        },
      );
    });

    group('submitApplication', () {
      test(
        'should return BusinessContactEntity '
        'when firebase has valid data',
        () async {
          const entity = ContactUsEntity(
            name: 'name',
            email: 'email',
            message: 'message',
          );
          mockFbFirestoreController.mockAddToCollection();

          await repository.submitApplication(entity);

          verify(
            () => mockFbFirestoreController.addToCollection(
              'contact_us',
              contactUsMapper.map(entity).toJson(),
            ),
          ).called(1);
        },
      );

      test(
        'should throw error when firebase throws exception',
        () {
          const entity = ContactUsEntity(
            name: 'name',
            email: 'email',
            message: 'message',
          );
          mockFbFirestoreController.mockAddToCollectionThrowsException();

          expect(
            () async => await repository.submitApplication(entity),
            throwsA(
              predicate(
                (exception) => exception is FirestoreException,
              ),
            ),
          );
        },
      );
    });
  });
}
