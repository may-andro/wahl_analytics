import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreException implements Exception {
  FirestoreException(this.cause, this.stackTrace);

  final Object cause;
  final StackTrace stackTrace;
}

class FbFirestoreController {
  FbFirestoreController(this._firebaseFirestore);

  final FirebaseFirestore _firebaseFirestore;

  Future<void> addToCollection(
    String collectionPath,
    Map<String, dynamic> data,
  ) {
    try {
      return _firebaseFirestore.collection(collectionPath).add(data);
    } catch (error, st) {
      throw FirestoreException(error, st);
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getCollectionQuerySnapshot(
    String collectionPath,
  ) {
    try {
      return _firebaseFirestore.collection(collectionPath).get();
    } catch (error, st) {
      throw FirestoreException(error, st);
    }
  }

  Future<void> addDocumentToCollection(
    String collectionPath,
    String documentPath,
    Map<String, dynamic> data,
  ) {
    try {
      return _firebaseFirestore
          .collection(collectionPath)
          .doc(documentPath)
          .set(data);
    } catch (error, st) {
      throw FirestoreException(error, st);
    }
  }

  Future<void> deleteDocumentFromCollection(
    String collectionPath,
    String documentPath,
  ) {
    try {
      return _firebaseFirestore
          .collection(collectionPath)
          .doc(documentPath)
          .delete();
    } catch (error, st) {
      throw FirestoreException(error, st);
    }
  }

  Future<Map<String, dynamic>?> getDocumentFromCollection(
    String collectionPath,
    String documentPath,
  ) async {
    try {
      final snapshot = await _firebaseFirestore
          .collection(collectionPath)
          .doc(documentPath)
          .get();
      if (snapshot.exists && snapshot.data() is Map<String, dynamic>) {
        return snapshot.data();
      }
      throw Exception('No collection found');
    } catch (error, st) {
      throw FirestoreException(error, st);
    }
  }

  Future<void> updateDocumentFromCollection(
    String collectionPath,
    String documentPath,
    Map<String, dynamic> data,
  ) {
    try {
      return _firebaseFirestore
          .collection(collectionPath)
          .doc(documentPath)
          .update(data);
    } catch (error, st) {
      throw FirestoreException(error, st);
    }
  }
}
