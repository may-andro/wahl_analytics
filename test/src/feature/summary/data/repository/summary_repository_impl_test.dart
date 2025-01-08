import 'package:core/core.dart';
import 'package:firebase/firebase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wahl_analytics/src/feature/summary/data/data.dart';
import 'package:wahl_analytics/src/feature/summary/domain/domain.dart';

import '../../../../../mock/firebase/mock_fb_firestore_controller.dart';

void main() {
  group('SummaryRepositoryImpl', () {
    late SummaryRepositoryImpl repository;

    late AppLocale appLocale;
    late BuildConfig buildConfig;
    late MockFbFirestoreController mockFbFirestoreController;
    late BusinessSummaryMapper businessSummaryMapper;

    final Map<String, dynamic> testSummaryData = {
      'en': {
        'title': 'title',
        'urls': ['url'],
        'descriptions': ['description'],
      },
    };

    const businessSummaryEntity = BusinessSummaryEntity(
      title: 'title',
      urls: ['url'],
      descriptions: ['description'],
    );

    setUp(() {
      appLocale = AppLocale('en');
      buildConfig = BuildConfig(buildEnvironment: BuildEnvironment.staging);
      mockFbFirestoreController = MockFbFirestoreController();
      businessSummaryMapper = BusinessSummaryMapper();

      repository = SummaryRepositoryImpl(
        appLocale,
        buildConfig,
        mockFbFirestoreController,
        businessSummaryMapper,
      );
    });

    group('getBusinessSummary', () {
      test(
        'should return BusinessSummaryEntity '
        'when firebase has valid data',
        () async {
          mockFbFirestoreController
              .mockGetDocumentFromCollection(testSummaryData);

          final result = await repository.getBusinessSummary();

          expect(result, businessSummaryEntity);
        },
      );

      test(
        'should throw NullDataFoundSummaryException '
        'when firebase has null data',
        () async {
          mockFbFirestoreController.mockGetDocumentFromCollection(null);

          expect(
            () async => await repository.getBusinessSummary(),
            throwsA(
              predicate(
                (exception) => exception is NullDataFoundSummaryException,
              ),
            ),
          );
        },
      );

      test(
        'should throw ServerSummaryException '
        'when firebase has FirestoreException exception',
        () async {
          final exception = FirestoreException(
            Exception(),
            StackTrace.current,
          );
          mockFbFirestoreController
              .mockGetDocumentFromCollectionThrowsException(exception);

          expect(
            () async => await repository.getBusinessSummary(),
            throwsA(
              predicate((exception) => exception is ServerSummaryException),
            ),
          );
        },
      );

      test(
        'should throw IncorrectJsonSummaryException '
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
            () async => await repository.getBusinessSummary(),
            throwsA(
              predicate(
                (exception) => exception is IncorrectJsonSummaryException,
              ),
            ),
          );
        },
      );

      test(
        'should throw UnknownSummaryException '
        'when json is different from expected',
        () async {
          final exception = Exception();
          mockFbFirestoreController
              .mockGetDocumentFromCollectionThrowsException(exception);

          expect(
            () async => await repository.getBusinessSummary(),
            throwsA(
              predicate(
                (exception) => exception is UnknownSummaryException,
              ),
            ),
          );
        },
      );
    });
  });
}
