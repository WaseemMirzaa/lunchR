import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luncher/app/routes/app_pages.dart';
import 'package:luncher/models/cefeteria_admin/meal_model.dart';
import 'package:luncher/services/Shared_preference/preferences.dart';
import 'package:luncher/services/meal_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CafeteriaMealDetailsController extends GetxController {
  final MealService _mealService = MealService();

  final nameController = TextEditingController();
  final availabilityController = TextEditingController();
  final priceController = TextEditingController();
  Rx<File?> selectedImage = Rx<File?>(null);
  RxString imageUrl = ''.obs; // Store the network image URL separately
  RxBool isLoading = false.obs;
  MealModel? meal;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserPreferences userPreferences = UserPreferences();

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is MealModel) {
      meal = Get.arguments as MealModel;
      _populateMealData();
    }
  }

  // Future<String?> getUserId() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('user_Id');
  // }
  void _populateMealData() {
    if (meal != null) {
      nameController.text = meal!.name ?? "";
      availabilityController.text = meal!.availability ?? "";
      priceController.text = meal!.price ?? "";
      imageUrl.value = meal!.imageUrl ?? ""; // Set network image URL
    }
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      imageUrl.value = ''; // Clear the old network image when new one is picked
    }
  }

  Future<void> submitMeal() async {
    final userId = await userPreferences.getUserId();
    print("user id is ${userId}");
    String name = nameController.text.trim();
    String availability = availabilityController.text.trim();
    String price = priceController.text.trim();
    if (name.isEmpty || availability.isEmpty || price.isEmpty) {
      Get.snackbar("Validation Error", "All fields are required");
      return;
    }

    isLoading.value = true;
    try {
      if (meal == null) {
        // Creating a new meal
        MealModel newMeal = MealModel(
          userId: userId,
          name: name,
          availability: availability,
          price: price,
        );
        await _mealService.addMeal(newMeal, selectedImage.value);
      } else {
        // Updating an existing meal
        await _mealService.updateMeal(meal!.id!, {
          // Set the user id
          "userId":userId,
          "name": name,
          "availability": availability,
          "price": price,
          if (selectedImage.value != null)
            "imageUrl": selectedImage.value!.path, // Upload new image if selected
        });
      }
      Get.offAndToNamed(Routes.CAFETERIA_LANDING_PAGE);
    } catch (e) {
      Get.snackbar("Error", "Failed to save meal. Please try again.");
    } finally {
      isLoading.value = false;
    }
  }
}
