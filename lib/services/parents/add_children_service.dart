import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luncher/models/cefeteria_admin/meal_model.dart';
import 'package:luncher/models/cefeteria_admin/meal_shedule_model.dart';
import 'package:luncher/models/parents_models/add_children.dart';
import 'package:luncher/models/user_model.dart';
import 'package:luncher/services/base_service.dart';

class AddChildrenService extends BaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Method to fetch unique school names
  Future<List<String>> getSchoolNames() async {
    try {
      QuerySnapshot snapshot = await firestore.collection('users').get();

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
  Stream<List<UserModel>> getCafeteriaSchool(String schoolName) {
    // try {
    // QuerySnapshot querySnapshot = await _firestore
    //     .collection('users')
    //     .where('schoolName', isEqualTo: schoolName)
    //     .get();
    //
    // return querySnapshot.docs
    //     .map((doc) => doc.data() as Map<String, dynamic>)
    //     .toList();
    return FirebaseFirestore.instance
        .collection("users")
        .where("schoolName", isEqualTo: schoolName) // ✅ Filter meals by userId
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        print("Fetched School Data is : ${doc.data()}");
        return UserModel.fromJson(doc.data());
      }).toList();
    });
    // } catch (e) {
    //   print("Error fetching users: $e");
    //   return const Stream.empty();
    // }
  }

  // Fetch all children for a specific parent ID
  Future<List<ParentsAddChildren>> fetchChildrenByParentId(String parentId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
          .collection("parentsChildren")
          .where("parentId", isEqualTo: parentId)
          .get();

      List<ParentsAddChildren> childrenList =
          querySnapshot.docs.map((doc) => ParentsAddChildren.fromJson(doc.data())).toList();

      return childrenList;
    } catch (e) {
      print("Error fetching children: $e");
      return [];
    }
  }

  Stream<List<MealModel>> getMealsByCafeteriaUser(String userId) {
    return FirebaseFirestore.instance
        .collection("meals")
        .where("userId", isEqualTo: userId) // ✅ Filter meals by userId
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        print("Fetched Meal: ${doc.data()}");
        return MealModel.fromMap(doc.id, doc.data());
      }).toList();
    });
  }

  Future<List<MealSheduleModel>> getPMealShedule(String userId, String mealId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("meal_schedules")
          .where("userId", isEqualTo: userId)
          .where("mealId", isEqualTo: mealId)
          .get();

      List<MealSheduleModel> meals = querySnapshot.docs.map((doc) {
        print("Fetched Meal: ${doc.data()}");
        return MealSheduleModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();

      return meals;
    } catch (e) {
      print("❌ Error fetching meal schedule: $e");
      return [];
    }
  }

  // ========= adding children =========
  /// **Add a Child to Firestore**
//   Future<bool> addOrUpdateChild(ParentsAddChildren childData) async {
//     final FirebaseFirestore firestore = FirebaseFirestore.instance;
//
//     try {
//       // Query Firestore for a child with the same `name` and `schoolId`
//       QuerySnapshot querySnapshot = await firestore
//           .collection('parentsChildren')
//           .where('childName', isEqualTo: childData.childName)
//           .where('childSchoolID', isEqualTo: childData.childSchoolID)
//           .get();
//
// // Print each document data
//       for (var doc in querySnapshot.docs) {
//         print("Document ID: ${doc.id}");
//         print("Data: ${doc.data()}");
//       }
//       if (querySnapshot.docs.isNotEmpty) {
//         print("Child data exist : //... ");
//
//         // If child exists, update the existing document
//         String existingChildId = querySnapshot.docs.first.id;
//         await firestore.collection('parentsChildren').doc(existingChildId).update(childData.toJson());
//
//         print("Child updated successfully: $existingChildId");
//       } else {
//         // If child doesn't exist, create a new one
//         DocumentReference childRef = firestore.collection('parentsChildren').doc();
//         Map<String, dynamic> childJson = childData.toJson();
//         childJson['id'] = childRef.id; // Store Firestore-generated ID in the model
//
//         await childRef.set(childJson);
//         print("New child added: ${childRef.id}");
//       }
//
//       return true; // Success
//     } catch (e) {
//       print("Error adding/updating child: $e");
//       return false; // Failure
//     }
//   }

  Future<bool> addChildren(ParentsAddChildren childData, String? imgUrl) async {
    print(" Index out of range :  ,,,,uuuuuuue ${imgUrl}");
    File imageFile = File(imgUrl!);
    String imagePath = imageFile.path;
    print(" Index out of range :  ,,,,uuuuuuue ${imagePath}");

    try {
      String docId = FirebaseFirestore.instance.collection("parentsChildren").doc().id;
      // Assign the generated ID to the meal model
      childData.id = docId;
      // Upload image if available
      if (imageFile != null) {
        String imageUrl = await uploadChildImage(imageFile, "parentsChildren", docId);
        if (imageUrl.isNotEmpty) {
          childData.childImageUrl = imageUrl; // Store the URL in Firestore
        }
      }
      await createDocument("parentsChildren", docId, childData.toJson());
      return true; // Success
    } catch (e) {
      print("Error adding child: $e");
      return false; // Failure
    }

  }

  //FOR DELETING ALL CHILDREN ON THE BASE  ARE CHILDREN ARE IN SAME SCHOOL(OF YES OR NO)
  Future<bool> deleteChildrenByParentId(String parentId) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Get all children where parentId matches
      QuerySnapshot querySnapshot = await firestore
          .collection('parentsChildren')
          .where('parentId', isEqualTo: parentId)
          .get();

      // Delete each document found
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await firestore.collection('parentsChildren').doc(doc.id).delete();
      }

      print("All children deleted for parent ID: $parentId");
      return true; // Success
    } catch (e) {
      print("Error deleting children: $e");
      return false; // Failure
    }
  }
}
