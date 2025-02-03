import 'package:get/get.dart';
import 'package:luncher/app/routes/app_pages.dart';
import 'package:luncher/services/authentication_service.dart';
import 'package:luncher/widgets/custom_snackbar.dart';

class PhoneVerificationController extends GetxController {
  final otpController = ''.obs; // Observable for OTP
  final isLoading = false.obs;

  final AuthenticationService _authService = AuthenticationService();

  // Handle OTP verification
  Future<void> verifyOTP(String verificationId) async {
    if (otpController.value.isEmpty || otpController.value.length < 6) {
      showCustomSnack("Please enter a valid OTP");
      return;
    }

    try {
      isLoading.value = true;

      // Call the service for OTP verification
      final result =
          await _authService.verifyOTP(verificationId, otpController.value);

      if (result.success) {
        Get.offAllNamed(Routes.LANDING_PAGE); // Navigate to home screen
      } else {
        showCustomSnack(result.message); // Show the error message
      }
    } finally {
      isLoading.value = false;
    }
  }
}
