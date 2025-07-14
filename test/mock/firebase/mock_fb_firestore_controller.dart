import 'package:firebase/firebase.dart';
import 'package:mocktail/mocktail.dart';

class MockFbFirestoreController extends Mock implements FbFirestoreController {
  void mockAddToCollection() {
    when(() => addToCollection(any(), any())).thenAnswer((_) async => {});
  }

  void mockAddToCollectionThrowsException() {
    when(
      () => addToCollection(any(), any()),
    ).thenThrow(FirestoreException(Exception(), StackTrace.current));
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
    when(
      () => updateDocumentFromCollection(any(), any(), any()),
    ).thenThrow(exception);
  }

  void mockGetCollectionQuerySnapshot(List<Map<String, dynamic>> expected) {
    when(
      () => getCollectionQuerySnapshot(
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
    ).thenAnswer((_) async => expected);
  }

  void mockGetCollectionQuerySnapshotThrowsException(Object exception) {
    when(
      () => getCollectionQuerySnapshot(
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
    ).thenThrow(exception);
  }

  void mockDeleteDocumentFromCollection() {
    when(
      () => deleteDocumentFromCollection(
        collectionPath: any(named: 'collectionPath'),
        documentPath: any(named: 'documentPath'),
      ),
    ).thenAnswer((_) async => {});
  }

  void mockDeleteDocumentFromCollectionThrowsException(Object exception) {
    when(
      () => deleteDocumentFromCollection(
        collectionPath: any(named: 'collectionPath'),
        documentPath: any(named: 'documentPath'),
      ),
    ).thenThrow(exception);
  }

  void mockAddDocumentToCollection() {
    when(
      () => addDocumentToCollection(
        collectionPath: any(named: 'collectionPath'),
        documentPath: any(named: 'documentPath'),
        data: any(named: 'data'),
      ),
    ).thenAnswer((_) async => {});
  }

  void mockAddDocumentToCollectionThrowsException(Object exception) {
    when(
      () => addDocumentToCollection(
        collectionPath: any(named: 'collectionPath'),
        documentPath: any(named: 'documentPath'),
        data: any(named: 'data'),
      ),
    ).thenThrow(exception);
  }
}
