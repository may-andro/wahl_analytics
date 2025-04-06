import 'dart:io';

import 'package:firebase/firebase.dart';
import 'package:mocktail/mocktail.dart';

class MockFbStorageController extends Mock implements FbStorageController {
  void mockUploadRawDocument(String expected) {
    when(
      () => uploadRawDocument(any(), any()),
    ).thenAnswer((_) async => expected);
  }

  void mockUploadRawDocumentThrowsException() {
    when(
      () => uploadRawDocument(any(), any()),
    ).thenThrow(StorageUploadFailedException(Exception(), StackTrace.current));
  }

  void mockDownloadFileDocument(File expected) {
    when(
      () => downloadFileDocument(
        fileName: any(named: 'fileName'),
        storageFolder: any(named: 'storageFolder'),
      ),
    ).thenAnswer((_) async => expected);
  }

  void mockDownloadFileDocumentThrowsException() {
    when(
      () => downloadFileDocument(
        fileName: any(named: 'fileName'),
        storageFolder: any(named: 'storageFolder'),
      ),
    ).thenThrow(StorageUploadFailedException(Exception(), StackTrace.current));
  }
}
