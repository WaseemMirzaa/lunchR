import 'package:get/get.dart';
import 'package:luncher/app/routes/app_pages.dart';
import 'package:luncher/models/user_model.dart';
import 'package:luncher/services/authentication_service.dart';
import 'package:luncher/services/parent_authentication-service.dart';
import 'package:luncher/services/parents/parenents_services.dart';
import 'package:luncher/widgets/custom_snackbar.dart';

class PhoneVerificationController extends GetxController {
  final otpController = ''.obs; // Observable for OTP
  final isLoading = false.obs;

  final ParentAuthenticationService _authService = ParentAuthenticationService();
  final ParentsServices _parentsService = ParentsServices();

  final String phoneNumber;
  final String verificationId;
  PhoneVerificationController({required this.phoneNumber, required this.verificationId});
  @override
  void onInit() {
    super.onInit();
    // You can now use verificationId and phoneNumber in your controller
    print('Verification ID: $verificationId');
    print('Phone Number: $phoneNumber');
  }

  // Handle OTP verification
  Future<void> verifyOTP() async {
    if (otpController.value.isEmpty || otpController.value.length < 6) {
      showCustomSnack("Please enter a valid OTP");
      return;
    }

    try {
      isLoading.value = true;

      // Call the service for OTP verification
      final result = await _authService.verifyOTP(verificationId, otpController.value);

      if (result.success) {
        final user = UserModel(
          phoneNumber: phoneNumber,
          role: 'parents',
          userAccountCreatedTime: DateTime.now(),
        );
        bool newParentsCreated = await _parentsService.createUser(user);
        // Get.offAllNamed(Routes.LANDING_PAGE);
        if (newParentsCreated || user.schoolName == null || user.schoolName!.isEmpty) {
          // Get.toNamed(Routes.CAFETERIA_DETAIL);
          Get.toNamed(Routes.PARENT_PROFILE);
        } else {
          print("yes else condition ");
          Get.offAllNamed(Routes.LANDING_PAGE);
        } // Navigate to home screen
      } else {
        showCustomSnack(result.message); // Show the error message
      }
    } finally {
      isLoading.value = false;
    }
  }
}
