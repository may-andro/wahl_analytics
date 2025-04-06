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

  Future<List<Map<String, dynamic>>> getCollectionQuerySnapshot(
    String collectionPath, {
    String? field,
    Object? isEqualTo,
    Object? isLessThan,
    Object? isGreaterThan,
    Object? isNotEqualTo,
    bool? descending,
    String? orderBy,
    int? limit,
  }) async {
    try {
      Query<Map<String, dynamic>> query = _firebaseFirestore.collection(
        collectionPath,
      );

      // Add filtering if a field and condition are provided
      if (field != null && isEqualTo != null) {
        query = query.where(field, isEqualTo: isEqualTo);
      }
      if (field != null && isLessThan != null) {
        query = query.where(field, isLessThan: isLessThan);
      }
      if (field != null && isGreaterThan != null) {
        query = query.where(field, isGreaterThan: isGreaterThan);
      }
      if (field != null && isNotEqualTo != null) {
        query = query.where(field, isNotEqualTo: isNotEqualTo);
      }

      // Add ordering if specified
      if (orderBy != null) {
        query = query.orderBy(orderBy, descending: descending ?? false);
      }

      // Add limit if specified
      if (limit != null) {
        query = query.limit(limit);
      }

      final queryData = await query.get();
      final snapshots = queryData.docs.where((doc) => doc.exists);

      return snapshots.map((snapshot) => snapshot.data()).toList();
    } catch (error, st) {
      throw FirestoreException(error, st);
    }
  }

  Future<void> addDocumentToCollection({
    required String collectionPath,
    required String documentPath,
    required Map<String, dynamic> data,
  }) {
    try {
      return _firebaseFirestore
          .collection(collectionPath)
          .doc(documentPath)
          .set(data);
    } catch (error, st) {
      throw FirestoreException(error, st);
    }
  }

  Future<void> deleteDocumentFromCollection({
    required String collectionPath,
    required String documentPath,
  }) {
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
