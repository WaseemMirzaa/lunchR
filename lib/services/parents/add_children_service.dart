import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luncher/models/cefeteria_admin/meal_model.dart';
import 'package:luncher/models/cefeteria_admin/meal_shedule_model.dart';
import 'package:luncher/models/parents_models/add_children.dart';
import 'package:luncher/models/user_model.dart';

class AddChildrenService {
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
          .where("userId", isEqualTo: userId).where("mealId", isEqualTo: mealId)
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
   Future<bool> addChildren(ParentsAddChildren childData) async {
     final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Generate a new document ID for the child
      DocumentReference childRef = firestore.collection('parentsChildren').doc();

      // Convert model to JSON format
      Map<String, dynamic> childJson = childData.toJson();
      childJson['id'] = childRef.id; // Store the auto-generated ID in the model

      // Save data to Firestore
      await childRef.set(childJson);

      return true; // Success
    } catch (e) {
      print("Error adding child: $e");
      return false; // Failure
    }
  }
}