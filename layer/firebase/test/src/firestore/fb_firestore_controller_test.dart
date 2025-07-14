import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase/src/firestore/fb_firestore_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

class MapListContains extends Matcher {
  const MapListContains(this._expected);

  final Map<dynamic, dynamic> _expected;

  @override
  Description describe(Description description) {
    return description.add('contains ').addDescriptionOf(_expected);
  }

  @override
  bool matches(dynamic item, Map<dynamic, dynamic> matchState) {
    if (item is List<Map>) {
      return item.any((element) => mapEquals(element, _expected));
    }
    return false;
  }
}

void main() {
  group(FbFirestoreController, () {
    late FbFirestoreController fbFirestoreController;

    late FakeFirebaseFirestore fakeFirebaseFirestore;

    const data = {'data': '42'};
    const collectionPath = 'collectionPath';
    const documentPath = 'documentPath';

    setUp(() {
      fakeFirebaseFirestore = FakeFirebaseFirestore();

      fbFirestoreController = FbFirestoreController(fakeFirebaseFirestore);
    });

    group('addToCollection', () {
      test('should add data to collection', () async {
        await fbFirestoreController.addToCollection(collectionPath, data);

        final querySnapshot = await fakeFirebaseFirestore
            .collection('collectionPath')
            .get();
        final actualDataList = querySnapshot.docs
            .map((snapshot) => snapshot.data())
            .toList();

        expect(actualDataList, const MapListContains(data));
      });
    });

    group('getCollectionQuerySnapshot', () {
      test('should get all collection', () async {
        await fakeFirebaseFirestore.collection(collectionPath).add(data);

        final result = await fbFirestoreController.getCollectionQuerySnapshot(
          collectionPath,
        );
        expect(result, const MapListContains(data));
      });
    });

    group('addDocumentToCollection', () {
      test('should add data to document', () async {
        await fbFirestoreController.addDocumentToCollection(
          collectionPath: collectionPath,
          documentPath: documentPath,
          data: data,
        );

        final documentReference = fakeFirebaseFirestore
            .collection(collectionPath)
            .doc(documentPath);
        final actualDocumentSnapshot = await documentReference.get();

        expect(actualDocumentSnapshot.data(), data);
      });
    });

    group('deleteDocumentFromCollection', () {
      test('should delete data from document', () async {
        final collectionReference = fakeFirebaseFirestore.collection(
          collectionPath,
        );
        final documentReference = await collectionReference.add(data);
        final String documentPath = documentReference.path;

        await fbFirestoreController.deleteDocumentFromCollection(
          collectionPath: collectionPath,
          documentPath: documentPath,
        );

        final documentSnapshot = await collectionReference
            .doc(documentPath)
            .get();

        expect(documentSnapshot.exists, false);
      });
    });

    group('getDocumentFromCollection', () {
      test('should get all documents', () async {
        final documentReference = fakeFirebaseFirestore
            .collection(collectionPath)
            .doc(documentPath);
        await documentReference.set(data);

        final expectedDocumentSnapshot = await documentReference.get();
        final expectedData = expectedDocumentSnapshot.data();

        final result = await fbFirestoreController.getDocumentFromCollection(
          collectionPath,
          documentPath,
        );

        expect(result, expectedData);
      });
    });

    group('updateDocumentFromCollection', () {
      test('should update the document', () async {
        final documentReference = fakeFirebaseFirestore
            .collection(collectionPath)
            .doc(documentPath);
        await documentReference.set(data);

        final Map<String, dynamic> dataUpdate = {'data': '43'};

        await fbFirestoreController.updateDocumentFromCollection(
          collectionPath,
          documentPath,
          dataUpdate,
        );

        final actualDocumentSnapshot = await documentReference.get();

        expect(actualDocumentSnapshot.data(), dataUpdate);
      });
    });
  });
}
