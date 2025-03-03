import 'package:get/get.dart';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:luncher/app/routes/app_pages.dart';
import 'package:luncher/services/authentication_service.dart';
import '../../../../widgets/custom_snackbar.dart';

class CafeteriaPhoneAuthenicationController extends GetxController {
  final phoneController = TextEditingController();
  final isLoading = false.obs;
  final isStaffLoading = false.obs;

  final AuthenticationService _authService = AuthenticationService();

  // Validate phone number
  bool validatePhoneNumber(String phoneNumber) {
    final phoneRegex = RegExp(r'^\+?[1-9]\d{9,14}$'); // International format
    if (phoneNumber.isEmpty) {
      showCustomSnack("Phone number can't be empty");
      return false;
    } else if (!phoneRegex.hasMatch(phoneNumber)) {
      showCustomSnack("Enter a valid phone number");
      return false;
    }
    return true;
  }
  //
  // // Handle phone number authentication
  // Future<void> authenticatePhoneNumber(
  //   bool isCafeteriaAdmin,
  // ) async {
  //   final phoneNumber = phoneController.text.trim();
  //
  //   log("Phone number: $phoneNumber");
  //
  //   if (!validatePhoneNumber(phoneNumber)) return;
  //
  //   isLoading.value = true;
  //
  //   // Call the service and wait for the result
  //   final result = await _authService.authenticatePhoneNumber(phoneNumber);
  //
  //   isLoading.value = false;
  //
  //   // Handle result
  //   if (result.success) {
  //     if (result.verificationId != null) {
  //       // Navigate to OTP verification screen
  //       isCafeteriaAdmin == true
  //           ? Get.toNamed(Routes.CAFETERIA_PHONE_VERIFICATION, arguments: {
  //               'verificationId': result.verificationId,
  //               'phoneNumber': phoneNumber,
  //             })
  //           : Get.toNamed(Routes.STAFF_PHONE_VERIFICATION, arguments: {
  //               'verificationId': result.verificationId,
  //               'phoneNumber': phoneNumber,
  //             });
  //     } else {
  //       // Navigate to the home screen if no verificationId (auto-verification)
  //       showCustomSnack(result.message);
  //     }
  //   } else {
  //     showCustomSnack(result.message);
  //   }
  // }
  Future<void> authenticatePhoneNumber(bool isCafeteriaAdmin) async {
    final phoneNumber = phoneController.text.trim();
    log("Entered Phone Number: $phoneNumber");

    if (!validatePhoneNumber(phoneNumber)) {
      showCustomSnack("Invalid phone number. Please enter a valid number.");
      return;
    }

    isLoading.value = true;

    try {
      final result = await _authService.authenticatePhoneNumber(phoneNumber);
      isLoading.value = false;

      if (result.success) {
        if (result.verificationId != null) {
          log("Verification ID received: ${result.verificationId}");

          // Navigate to OTP verification screen
          Get.toNamed(
            isCafeteriaAdmin ? Routes.CAFETERIA_PHONE_VERIFICATION : Routes.STAFF_PHONE_VERIFICATION,
            arguments: {
              'verificationId': result.verificationId,
              'phoneNumber': phoneNumber,
            },
          );
        } else {
          showCustomSnack(result.message);
        }
      } else {
        log("Authentication failed: ${result.message}");
        showCustomSnack(result.message);
      }
    } catch (e) {
      isLoading.value = false;
      log("Error in phone authentication: $e");
      showCustomSnack("An unexpected error occurred. Please try again.");
    }
  }

}
