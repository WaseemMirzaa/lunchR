import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

abstract class BaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> createDocument(
      String collectionPath, String docId, Map<String, dynamic> data) async {
    await _firestore.collection(collectionPath).doc(docId).set(data);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDocument(
      String collectionPath, String docId) {
    return _firestore.collection(collectionPath).doc(docId).get();
  }

  Future<void> updateDocument(
      String collectionPath, String docId, Map<String, dynamic> data) async {
    await _firestore.collection(collectionPath).doc(docId).update(data);
  }

  Future<void> deleteDocument(String collectionPath, String docId) async {
    await _firestore.collection(collectionPath).doc(docId).delete();
  }

  // New method to delete image from Firebase Storage
  Future<void> deleteStorage(String folderName, String docId) async {
    try {
      Reference ref = _storage.ref().child('$folderName/$docId.jpg');
      await ref.delete(); // Delete the image from Firebase Storage
    } catch (e) {
      throw Exception("Image deletion failed: $e");
    }
  }

  Future<String> uploadImage(
      File imageFile, String folderName, String docId) async {
    try {
      Reference ref = _storage.ref().child('$folderName/$docId.jpg');
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      throw Exception("Image upload failed: $e");
    }
  }
}
