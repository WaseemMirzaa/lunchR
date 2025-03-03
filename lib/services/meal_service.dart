import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:luncher/models/cefeteria_admin/meal_model.dart';
import 'package:luncher/services/base_service.dart';

class MealService extends BaseService {
  Future<void> addMeal(MealModel meal, File? imageFile) async {
    String docId = FirebaseFirestore.instance.collection("meals").doc().id;

    // Assign the generated ID to the meal model
    meal.id = docId;

    // Upload image if available
    if (imageFile != null) {
      meal.imageUrl = await uploadImage(imageFile, "meals", docId);
    }

    // Save meal to Firestore
    await createDocument("meals", docId, meal.toMap());
  }

  Stream<List<MealModel>> getMeals() {
    return FirebaseFirestore.instance.collection("meals").snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          print("sss#ll ${doc.data()}");

          return MealModel.fromMap(doc.id, doc.data());
        }).toList();
      },
    );
  }

  Future<void> updateMeal(String mealId, Map<String, dynamic> data) async {
    await updateDocument("meals", mealId, data);
  }

  Future<void> deleteMeal(String mealId) async {
    await deleteDocument("meals", mealId);
    await deleteStorage("meals", mealId);
  }
}
