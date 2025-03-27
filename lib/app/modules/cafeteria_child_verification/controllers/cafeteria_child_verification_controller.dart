import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CafeteriaChildVerificationController extends GetxController {
  final schoolIdController = TextEditingController();
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final isValid = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Add listener to validate on every change
    schoolIdController.addListener(_validateSchoolId);
  }

  @override
  void onClose() {
    schoolIdController.removeListener(_validateSchoolId);
    schoolIdController.dispose();
    super.onClose();
  }

  void _validateSchoolId() {
    String value = schoolIdController.text.trim();
    
    if (value.isEmpty) {
      errorMessage.value = 'School ID is required';
      isValid.value = false;
    } else if (value.length < 3) {
      errorMessage.value = 'School ID must be at least 3 characters';
      isValid.value = false;
    } else if (value.length > 20) {
      errorMessage.value = 'School ID cannot exceed 20 characters';
      isValid.value = false;
    } else if (!RegExp(r'^[a-zA-Z0-9-_]+$').hasMatch(value)) {
      errorMessage.value = 'Only letters, numbers, hyphens and underscores allowed';
      isValid.value = false;
    } else {
      errorMessage.value = '';
      isValid.value = true;
    }
  }

  void verifyChildId() {
    String value = schoolIdController.text.trim();
    _validateSchoolId();
    
    if (!isValid.value) {
      Get.snackbar(
        'Validation Error',
        errorMessage.value,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
        duration: const Duration(seconds: 3),
      );
      return;
    }

    print('Verifying Child School ID: $value');
    // Proceed with verification logic here
  }
}
