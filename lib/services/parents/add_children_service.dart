import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:snacktag/models/cefeteria_admin/meal_model.dart';
import 'package:snacktag/models/cefeteria_admin/meal_shedule_model.dart';
import 'package:snacktag/models/parents_models/add_children.dart';
import 'package:snacktag/models/user_model.dart';
import 'package:snacktag/services/base_service.dart';

class AddChildrenService extends BaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Method to fetch unique school names
  Future<List<String>> getSchoolNames() async {
    try {
      QuerySnapshot snapshot = await firestore.collection('users').get();

      List<String> schoolNames = snapshot.docs
          .map((doc) => doc['schoolName'] as String?)
          .where((name) =>
              name != null && name.isNotEmpty) // Filter out null & empty values
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
  Future<List<ParentsAddChildren>> fetchChildrenByParentId(
      String parentId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
          .collection("parentsChildren")
          .where("parentId", isEqualTo: parentId)
          .get();

      List<ParentsAddChildren> childrenList = querySnapshot.docs
          .map((doc) => ParentsAddChildren.fromJson(doc.data()))
          .toList();

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

  Future<List<MealSheduleModel>> getPMealShedule(
      String userId, String mealId) async {
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
  Future<bool> addOrUpdateChild(
      ParentsAddChildren childData, String? imgUrl) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    print("Parent ID: ${childData.parentId}, Child ID: ${childData.childId}");

    try {
      // Query Firestore for an existing child
      QuerySnapshot querySnapshot = await firestore
          .collection('parentsChildren')
          .where('parentId', isEqualTo: childData.parentId)
          .where('childId', isEqualTo: childData.childId)
          .get();

      // Print all matched documents
      for (var doc in querySnapshot.docs) {
        print("Document ID: ${doc.id}");
        print("Data: ${doc.data()}");
      }

      if (querySnapshot.docs.isNotEmpty) {
        print("Child data exists, updating...");

        // Get the existing document ID
        String existingChildId = querySnapshot.docs.first.id;
        DocumentReference childDocRef =
            firestore.collection('parentsChildren').doc(existingChildId);

        // If a new image is provided, upload it and update Firestore
        if (imgUrl != null && imgUrl.isNotEmpty) {
          File imageFile = File(imgUrl);
          String imageUrl = await uploadChildImage(imageFile,
              "parentsChildren/${childData.parentId}", existingChildId);
          if (imageUrl.isNotEmpty) {
            childData.childImageUrl = imageUrl; // Store the new image URL
          }
        }

        // Update the existing child data
        await childDocRef.update(childData.toJson());
        print("Child updated successfully: $existingChildId");
      } else {
        print("Child does not exist, adding new child...");

        // Create a new document
        DocumentReference childRef =
            firestore.collection('parentsChildren').doc();
        childData.id = childRef.id; // Assign Firestore-generated ID

        // If an image is provided, upload it
        if (imgUrl != null && imgUrl.isNotEmpty) {
          File imageFile = File(imgUrl);
          String imageUrl = await uploadChildImage(
              imageFile, "parentsChildren/${childData.parentId}", childRef.id);
          if (imageUrl.isNotEmpty) {
            childData.childImageUrl = imageUrl; // Store the image URL
          }
        }

        // Save new child data to Firestore
        await childRef.set(childData.toJson());
        print("New child added successfully: ${childRef.id}");
      }

      return true;
    } catch (e) {
      print("Error adding/updating child: $e");
      return false;
    }
  }

  Future<bool> addChildren(ParentsAddChildren childData, String? imgUrl) async {
    print(" Index out of range :  ,,,,uuuuuuue ${imgUrl}");
    File imageFile = File(imgUrl!);
    String imagePath = imageFile.path;
    print(" Index out of range :  ,,,,uuuuuuue ${imagePath}");

    try {
      String docId =
          FirebaseFirestore.instance.collection("parentsChildren").doc().id;
      // Assign the generated ID to the meal model
      childData.id = docId;
      // Upload image if available
      if (imageFile != null) {
        String imageUrl =
            await uploadChildImage(imageFile, "parentsChildren", docId);
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
  // ========= Update  children  against Parint id and child id =========

  Future<bool> updateChildren(String parentId, String childId,
      ParentsAddChildren childData, String? imgUrl) async {
    print("Updating child data for parentId: $parentId, childId: $childId");
    print("Image URL: $imgUrl");

    try {
      // Reference to Firestore document
      DocumentReference childDocRef = FirebaseFirestore.instance
          .collection("parentsChildren")
          .doc(childId); // Access the document directly

      // If a new image is provided, upload it and update the URL
      if (imgUrl != null && imgUrl.isNotEmpty) {
        File imageFile = File(imgUrl);
        String imageUrl = await uploadChildImage(
            imageFile, "parentsChildren/$parentId", childId);
        if (imageUrl.isNotEmpty) {
          childData.childImageUrl = imageUrl;
        }
      }

      // Update Firestore document
      await childDocRef.update(childData.toJson());

      print("Child updated successfully");
      return true;
    } catch (e) {
      print("Error updating child: $e");
      return false;
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
