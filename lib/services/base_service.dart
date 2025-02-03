import 'package:cloud_firestore/cloud_firestore.dart';

class BaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Singleton Pattern
  static final BaseService _instance = BaseService._internal();
  factory BaseService() => _instance;
  BaseService._internal();

  /// Create or Update a Document
  Future<void> setDocument(
      {required String collectionPath,
      required String docId,
      required Map<String, dynamic> data}) async {
    try {
      await _firestore.collection(collectionPath).doc(docId).set(data);
    } catch (e) {
      print('Error during setDocument: $e');
      rethrow;
    }
  }

  /// Add a Document (Auto-ID)
  Future<DocumentReference> addDocument(
      {required String collectionPath, required Map<String, dynamic> data}) async {
    try {
      return await _firestore.collection(collectionPath).add(data);
    } catch (e) {
      print('Error during addDocument: $e');
      rethrow;
    }
  }

  /// Read a Document
  Future<DocumentSnapshot> getDocument(
      {required String collectionPath, required String docId}) async {
    try {
      return await _firestore.collection(collectionPath).doc(docId).get();
    } catch (e) {
      print('Error during getDocument: $e');
      rethrow;
    }
  }

  /// Read All Documents in a Collection
  Future<List<QueryDocumentSnapshot>> getCollection(
      {required String collectionPath}) async {
    try {
      final QuerySnapshot querySnapshot =
          await _firestore.collection(collectionPath).get();
      return querySnapshot.docs;
    } catch (e) {
      print('Error during getCollection: $e');
      rethrow;
    }
  }

  /// Update a Document
  Future<void> updateDocument(
      {required String collectionPath,
      required String docId,
      required Map<String, dynamic> data}) async {
    try {
      await _firestore.collection(collectionPath).doc(docId).update(data);
    } catch (e) {
      print('Error during updateDocument: $e');
      rethrow;
    }
  }

  /// Delete a Document
  Future<void> deleteDocument(
      {required String collectionPath, required String docId}) async {
    try {
      await _firestore.collection(collectionPath).doc(docId).delete();
    } catch (e) {
      print('Error during deleteDocument: $e');
      rethrow;
    }
  }
}
