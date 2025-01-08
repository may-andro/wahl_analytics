import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wahl_analytics/src/feature/career/data/data.dart';
import 'package:wahl_analytics/src/feature/career/domain/domain.dart';

import '../../../../../mock/firebase/mock_fb_firestore_controller.dart';
import '../../../../../mock/firebase/mock_fb_storage_controller.dart';

void main() {
  group('CareerRepositoryImpl', () {
    late CareerRepositoryImpl repository;

    late MockFbStorageController mockFbStorageController;
    late MockFbFirestoreController mockFbFirestoreController;

    setUpAll(() {
      registerFallbackValue(Uint8List.fromList([0, 1, 2, 3]));
    });

    setUp(() {
      mockFbStorageController = MockFbStorageController();
      mockFbFirestoreController = MockFbFirestoreController();

      repository = CareerRepositoryImpl(
        mockFbStorageController,
        mockFbFirestoreController,
        CareerMapper(),
      );
    });

    group('submitCareerApplication', () {
      test('should uploads resume and submits application', () async {
        const url = 'https://example.com/resume.pdf';
        final careerEntity = CareerEntity(
          name: 'Name',
          email: 'email',
          role: 'role',
          country: 'country',
          message: 'message',
          fileData: Uint8List.fromList([0, 1, 2, 3]),
        );
        mockFbStorageController.mockUploadRawDocument(url);
        mockFbFirestoreController.mockAddToCollection();

        await repository.submitCareerApplication(careerEntity);

        verify(
          () => mockFbStorageController.uploadRawDocument(any(), any()),
        ).called(1);
        verify(
          () => mockFbFirestoreController.addToCollection(any(), any()),
        ).called(1);
      });

      test(
          'should propagates exception '
          'when occurs while uploading document', () async {
        final careerEntity = CareerEntity(
          name: 'Name',
          email: 'email',
          role: 'role',
          country: 'country',
          message: 'message',
          fileData: Uint8List.fromList([0, 1, 2, 3]),
        );
        mockFbStorageController.mockUploadRawDocumentThrowsException();
        mockFbFirestoreController.mockAddToCollection();

        await expectLater(
          repository.submitCareerApplication(careerEntity),
          throwsException,
        );

        verify(
          () => mockFbStorageController.uploadRawDocument(any(), any()),
        ).called(1);
        verifyNever(
          () => mockFbFirestoreController.addToCollection(any(), any()),
        );
      });

      test(
          'should propagates exception '
          'when updating firestore', () async {
        const url = 'https://example.com/resume.pdf';
        final careerEntity = CareerEntity(
          name: 'Name',
          email: 'email',
          role: 'role',
          country: 'country',
          message: 'message',
          fileData: Uint8List.fromList([0, 1, 2, 3]),
        );
        mockFbStorageController.mockUploadRawDocument(url);
        mockFbFirestoreController.mockAddToCollectionThrowsException();

        await expectLater(
          repository.submitCareerApplication(careerEntity),
          throwsException,
        );

        verify(
          () => mockFbStorageController.uploadRawDocument(any(), any()),
        ).called(1);
        verify(
          () => mockFbFirestoreController.addToCollection(any(), any()),
        ).called(1);
      });
    });
  });
}
