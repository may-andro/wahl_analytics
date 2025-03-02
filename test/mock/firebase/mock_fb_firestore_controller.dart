import 'package:firebase/firebase.dart';
import 'package:mocktail/mocktail.dart';

class MockFbFirestoreController extends Mock implements FbFirestoreController {
  void mockAddToCollection() {
    when(() => addToCollection(any(), any())).thenAnswer((_) async => {});
  }

  void mockAddToCollectionThrowsException() {
    when(() => addToCollection(any(), any())).thenThrow(
      FirestoreException(Exception(), StackTrace.current),
    );
  }

  void mockGetDocumentFromCollection(Map<String, dynamic>? expected) {
    when(
      () => getDocumentFromCollection(any(), any()),
    ).thenAnswer((_) async => expected);
  }

  void mockGetDocumentFromCollectionThrowsException(Object exception) {
    when(() => getDocumentFromCollection(any(), any())).thenThrow(exception);
  }

  void mockUpdateDocumentFromCollection() {
    when(
      () => updateDocumentFromCollection(any(), any(), any()),
    ).thenAnswer((_) async => {});
  }

  void mockUpdateDocumentFromCollectionThrowsException(Object exception) {
    when(() => updateDocumentFromCollection(any(), any(), any()))
        .thenThrow(exception);
  }
}
