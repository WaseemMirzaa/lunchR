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
  final pin = ''.obs;

  final AuthenticationService _authService = AuthenticationService();
  final UserService _userService = UserService();

  final String verificationId;
  final String phoneNumber;

  CafeteriaPhoneVerificationController({
    required this.verificationId,
    required this.phoneNumber,
  });

  // Handle OTP verification
  Future<void> verifyOTP() async {
    if (otpController.value.isEmpty || otpController.value.length < 6) {
      showCustomSnack("Please enter a valid OTP");
      return;
    }

    try {
      isLoading.value = true;

      final result = await _authService.verifyOTP(verificationId, otpController.value);
      if (result.success) {
        final user = UserModel(
          phoneNumber: phoneNumber,
          role: 'cafeteriaAdmin',
          userAccountCreatedTime: DateTime.now(),
        );

        UserModel newUserCreated = await _userService.createUser(user);
        print(
            "new user is ${newUserCreated.cafeteriaName},${newUserCreated.phoneNumber},${newUserCreated.cafeteriaLogo}");
        if(newUserCreated.cafeteriaName==null || newUserCreated.cafeteriaLogo==null || newUserCreated.schoolName==null) {
          print("User  new Status is $result");

          Get.toNamed(Routes.CAFETERIA_DETAIL);

        } else {
          print("User old Status is $result");

          Get.offAllNamed(Routes.CAFETERIA_LANDING_PAGE);

        }
        // if (newUserCreated || user.cafeteriaName == null || user.cafeteriaName!.isEmpty) {
        //   print("User is new or cafeteriaName is empty. Navigating to CAFETERIA_DETAIL.");
        //   // Get.toNamed(Routes.CAFETERIA_DETAIL);
        // } else {
        //   print("User already exists. Navigating to CAFETERIA_LANDING_PAGE.");
        //   // Get.offAllNamed(Routes.CAFETERIA_LANDING_PAGE);
        // }
      } else {
        showCustomSnack(result.message);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
