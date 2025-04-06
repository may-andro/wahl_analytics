import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wahl_analytics/src/feature/career/data/data.dart';
import 'package:wahl_analytics/src/feature/career/domain/domain.dart';

import '../../../../../mock/firebase/mock_fb_firestore_controller.dart';
import '../../../../../mock/firebase/mock_fb_storage_controller.dart';

class MockBuildConfig extends Mock implements BuildConfig {
  void mockBuildEnvironment(BuildEnvironment expected) {
    when(() => buildEnvironment).thenReturn(expected);
  }
}

void main() {
  group(CareerRepositoryImpl, () {
    late CareerRepositoryImpl repository;

    late MockBuildConfig mockBuildConfig;
    late MockFbStorageController mockFbStorageController;
    late MockFbFirestoreController mockFbFirestoreController;

    setUpAll(() {
      registerFallbackValue(Uint8List.fromList([0, 1, 2, 3]));
    });

    setUp(() {
      mockBuildConfig = MockBuildConfig()
        ..mockBuildEnvironment(BuildEnvironment.prod);
      mockFbStorageController = MockFbStorageController();
      mockFbFirestoreController = MockFbFirestoreController();

      repository = CareerRepositoryImpl(
        mockBuildConfig,
        mockFbStorageController,
        mockFbFirestoreController,
        CareerApplicationMapper(),
        CareerMapper(),
      );
    });

    group('submitCareerApplication', () {
      test('should uploads resume and submits application', () async {
        mockFbStorageController.mockUploadRawDocument(
          'https://example.com/resume.pdf',
        );
        mockFbFirestoreController.mockAddDocumentToCollection();

        await repository
            .submitCareerApplication(CareerApplicationEntity.test());

        verify(
          () => mockFbStorageController.uploadRawDocument(any(), any()),
        ).called(1);
        verify(
          () => mockFbFirestoreController.addDocumentToCollection(
            collectionPath: any(named: 'collectionPath'),
            documentPath: any(named: 'documentPath'),
            data: any(named: 'data'),
          ),
        ).called(1);
      });

      test(
          'should propagates exception '
          'when occurs while uploading document', () async {
        mockFbStorageController.mockUploadRawDocumentThrowsException();

        await expectLater(
          repository.submitCareerApplication(CareerApplicationEntity.test()),
          throwsException,
        );

        verify(
          () => mockFbStorageController.uploadRawDocument(any(), any()),
        ).called(1);
        verifyNever(
          () => mockFbFirestoreController.addDocumentToCollection(
            collectionPath: any(named: 'collectionPath'),
            documentPath: any(named: 'documentPath'),
            data: any(named: 'data'),
          ),
        );
      });

      test(
          'should propagates exception '
          'when updating firestore', () async {
        mockFbStorageController.mockUploadRawDocument(
          'https://example.com/resume.pdf',
        );
        mockFbFirestoreController.mockAddDocumentToCollectionThrowsException(
          Exception(),
        );

        await expectLater(
          repository.submitCareerApplication(CareerApplicationEntity.test()),
          throwsException,
        );

        verify(
          () => mockFbStorageController.uploadRawDocument(any(), any()),
        ).called(1);
        verify(
          () => mockFbFirestoreController.addDocumentToCollection(
            collectionPath: any(named: 'collectionPath'),
            documentPath: any(named: 'documentPath'),
            data: any(named: 'data'),
          ),
        ).called(1);
      });
    });

    group('getCareersRequest', () {
      test('should return list of $CareerEntity when data is available in FS',
          () async {
        final Map<String, dynamic> testCareerData = {
          'name': 'John Doe',
          'email': 'john.doe@example.com',
          'role': 'Software Engineer',
          'country': 'USA',
          'message': 'Excited to apply for this role!',
          'resumeName': 'john_doe_resume.pdf',
          'resumeUrl': 'https://example.com/resumes/john_doe_resume.pdf',
          'uploadedAt': 'Sunday, April 6, 2025 19:41',
          'env': 'production',
        };

        mockFbFirestoreController.mockGetCollectionQuerySnapshot(
          <Map<String, dynamic>>[testCareerData],
        );

        final result = await repository.getCareersRequest();

        verify(
          () => mockFbFirestoreController.getCollectionQuerySnapshot(
            'career',
            field: 'env',
            isEqualTo: 'prod',
          ),
        ).called(1);

        final careerEntity = result.first;
        expect(result.length, 1);
        expect(careerEntity.name, equals(testCareerData['name']));
        expect(careerEntity.email, equals(testCareerData['email']));
        expect(careerEntity.role, equals(testCareerData['role']));
        expect(careerEntity.country, equals(testCareerData['country']));
        expect(careerEntity.message, equals(testCareerData['message']));
        expect(careerEntity.resumeUrl, equals(testCareerData['resumeUrl']));
        expect(careerEntity.resumeName, equals(testCareerData['resumeName']));
        expect(
          careerEntity.uploadedAt,
          equals((testCareerData['uploadedAt'] as String).toFullDateTime),
        );
      });

      test(
          'should propagates exception '
          'when add to firestore fails', () async {
        mockFbFirestoreController
            .mockGetCollectionQuerySnapshotThrowsException(Exception());

        await expectLater(
          repository.getCareersRequest(),
          throwsException,
        );

        verify(
          () => mockFbFirestoreController.getCollectionQuerySnapshot(
            any(),
            field: any(named: 'field'),
            isEqualTo: any(named: 'isEqualTo'),
            isLessThan: any(named: 'isLessThan'),
            isGreaterThan: any(named: 'isGreaterThan'),
            isNotEqualTo: any(named: 'isNotEqualTo'),
            descending: any(named: 'descending'),
            orderBy: any(named: 'orderBy'),
            limit: any(named: 'limit'),
          ),
        ).called(1);
      });
    });

    group('deleteCareerRequest', () {
      test('should call FS to delete the $CareerEntity', () async {
        mockFbFirestoreController.mockDeleteDocumentFromCollection();

        await repository.deleteCareerRequest(CareerEntity.test());

        verify(
          () => mockFbFirestoreController.deleteDocumentFromCollection(
            documentPath: any(named: 'documentPath'),
            collectionPath: any(named: 'collectionPath'),
          ),
        ).called(1);
      });

      test(
          'should propagates exception '
          'when deleting to firestore fails', () async {
        mockFbFirestoreController
            .mockDeleteDocumentFromCollectionThrowsException(Exception());

        await expectLater(
          repository.deleteCareerRequest(CareerEntity.test()),
          throwsException,
        );

        verify(
          () => mockFbFirestoreController.deleteDocumentFromCollection(
            collectionPath: any(named: 'collectionPath'),
            documentPath: any(named: 'documentPath'),
          ),
        ).called(1);
      });
    });
  });
}
