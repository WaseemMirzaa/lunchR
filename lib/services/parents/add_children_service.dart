import 'package:cloud_firestore/cloud_firestore.dart';

class AddChildrenService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to fetch unique school names
  Future<List<String>> getSchoolNames() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('users').get();

      List<String> schoolNames = snapshot.docs
          .map((doc) => doc['schoolName'] as String?)
          .where((name) => name != null && name.isNotEmpty) // Filter out null & empty values
          .cast<String>()
          .toList();

      return schoolNames;
    } catch (e) {
      print("Error fetching school names: $e");
      return [];
    }
  }
  /// Fetch users where `schoolName` matches the given input
  Future<List<Map<String, dynamic>>> getCafeteriaSchool(String schoolName) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('schoolName', isEqualTo: schoolName)
          .get();

      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print("Error fetching users: $e");
      return [];
    }
  }
  // Future<List<String>> getSchoolNames() async {
  //   try {
  //     // Fetch all user documents from the "users" collection
  //     QuerySnapshot querySnapshot = await _firestore.collection('users').get();
  //
  //     // Extract school names
  //     List<String> schoolNames = querySnapshot.docs
  //         .map((doc) => doc['schoolName'] as String) // Extract field
  //         .toSet() // Remove duplicates
  //         .toList(); // Convert to list
  //
  //     return schoolNames;
  //   } catch (e) {
  //     print("Error fetching school names: $e");
  //     return [];
  //   }
  // }
}
