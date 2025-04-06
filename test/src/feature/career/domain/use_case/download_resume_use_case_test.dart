import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:wahl_analytics/src/feature/career/domain/entity/career_entity.dart';
import 'package:wahl_analytics/src/feature/career/domain/use_case/download_resume_use_case.dart';

import '../../../../../mock/firebase/mock_fb_storage_controller.dart';

void main() {
  group(DownloadResumeUseCase, () {
    late DownloadResumeUseCase useCase;

    late MockFbStorageController mockFbStorageController;

    setUp(() {
      mockFbStorageController = MockFbStorageController();

      useCase = DownloadResumeUseCase(mockFbStorageController);
    });

    test('should call repository to get the career applications', () async {
      final file = File('path');
      mockFbStorageController.mockDownloadFileDocument(file);

      final result = await useCase(CareerEntity.test());

      expect(result.isRight, isTrue);
      expect(result.right, file);
    });

    test(
        'should return $DownloadResumeFailure'
        ' when exception occurs', () async {
      mockFbStorageController.mockDownloadFileDocumentThrowsException();

      final result = await useCase(CareerEntity.test());

      expect(result.isLeft, isTrue);
      expect(result.left, isA<DownloadResumeFailure>());
    });
  });
}
