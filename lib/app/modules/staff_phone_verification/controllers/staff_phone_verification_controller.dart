import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luncher/app/routes/app_pages.dart';
import 'package:luncher/services/authentication_service.dart';
import 'package:luncher/widgets/custom_snackbar.dart';

class StaffPhoneVerificationController extends GetxController {
  final isLoading = false.obs;
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthenticationService _authService = AuthenticationService();

  // Handle OTP verification
  Future<void> staffLogin() async {
    isLoading.value = true;
    String staffPhone = phoneController.text.trim();
    String staffPassword = passwordController.text.trim();
    if (staffPhone.isEmpty || staffPassword.isEmpty) {
      showCustomSnack("Phone And Password Can't Empty");
      return;
    }
    Future.delayed(Duration(seconds: 2));

    try {

      bool phoneExists = await _authService.isPhoneNumberExists(staffPhone);
      if (!phoneExists) {
       return showCustomSnack("Phone Number Not Exist Please Enter Correct Phone Number");
      }
       await _authService.staffLogin(staffPhone,staffPassword).then((val){

         Get.offAllNamed(Routes.STAFF_LANDING_PAGE);

       }).catchError((error, stacktrace) {
         // Handle the error
         showCustomSnack(error.toString());

       });


      // final result =
      //     await _authService.verifyOTP(verificationId, otpController.value);
      //
      // if (result.success) {
      //   Get.offAllNamed(Routes.LANDING_PAGE); // Navigate to home screen
      // } else {
      //   showCustomSnack(result.message); // Show the error message
      // }
    } finally {
      isLoading.value = false;
    }
  }
}
