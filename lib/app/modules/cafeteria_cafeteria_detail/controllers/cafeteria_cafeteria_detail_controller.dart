import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luncher/services/base_service.dart';

class CafeteriaCafeteriaDetailController extends GetxController {
  // State variables
  final RxnString selectedImage = RxnString(null);
  final RxBool isLoading = RxBool(false);

  // Text Editing Controllers
  final TextEditingController mealController = TextEditingController();
  final TextEditingController schoolController = TextEditingController();

  final BaseService baseService = BaseService();

  // Image picker method
  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      selectedImage.value = pickedFile.path;
    }
  }

  // Validate input fields
  String? validateFields() {
    if (mealController.text.trim().isEmpty) return "Cafeteria name is required";
    if (schoolController.text.trim().isEmpty) {
      return "School/College name is required";
    }
    if (selectedImage.value == null) return "Please select an image";
    return null;
  }

  // Upload data to Firestore
  Future<void> uploadDataToFirestore() async {
    final error = validateFields();
    if (error != null) {
      Get.snackbar("Error", error, snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true;

    try {
      final data = {
        'mealName': mealController.text.trim(),
        'schoolName': schoolController.text.trim(),
        'imageUrl': selectedImage.value,
      };

      await baseService.addDocument(collectionPath: 'cafeteria', data: data);

      Get.toNamed('/cafeteria-meal-details');
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
  
}
