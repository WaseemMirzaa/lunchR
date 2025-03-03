import 'package:get/get.dart';
import 'package:luncher/models/user_model.dart';
import 'package:luncher/app/routes/app_pages.dart';
import 'package:luncher/services/authentication_service.dart';
import 'package:luncher/services/user_service.dart';
import 'package:luncher/widgets/custom_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CafeteriaPhoneVerificationController extends GetxController {
  final otpController = ''.obs; // Observable for OTP
  final isLoading = false.obs;

  final AuthenticationService _authService = AuthenticationService();
  final UserService _userService = UserService();

  // Handle OTP verification
  Future<void> verifyOTP(String verificationId, String phoneNumber) async {
    if (otpController.value.isEmpty || otpController.value.length < 6) {
      showCustomSnack("Please enter a valid OTP");
      return;
    }

    try {
      isLoading.value = true;

      final result =
          await _authService.verifyOTP(verificationId, otpController.value);

      if (result.success) {
        final user = UserModel(
          phoneNumber: phoneNumber,
          role: 'cafeteriaAdmin',
          userAccountCreatedTime: DateTime.now(),
        );

        await _userService.createUser(user);

        Get.offAllNamed(Routes.CAFETERIA_LANDING_PAGE);
      } else {
        showCustomSnack(result.message);
      }
    } finally {
      isLoading.value = false;
    }
  }

}
