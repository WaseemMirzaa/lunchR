import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luncher/app/routes/app_pages.dart';
import 'package:luncher/config/app_colors.dart';
import 'package:luncher/config/app_text_style.dart';
import 'package:luncher/widgets/reuse_button.dart';
import 'package:pinput/pinput.dart';

import '../controllers/cafeteria_phone_verification_controller.dart';

class CafeteriaPhoneVerificationView
    extends GetView<CafeteriaPhoneVerificationController> {
  const CafeteriaPhoneVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    Rx<int> timer = 45.obs; // Timer for 1 minute
    RxBool isTimerRunning = true.obs;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: AppTextStyles.PoppinsRegular.copyWith(
        fontSize: 33,
        color: const Color(0xFF858585),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white, width: 3),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(40),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    );

    final submittedPinTheme = defaultPinTheme.copyDecorationWith(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    );

    void startTimer() {
      if (isTimerRunning.value) {
        Future.delayed(const Duration(seconds: 1), () {
          if (timer.value > 0) {
            timer.value--;
            startTimer();
          } else {
            isTimerRunning.value = false;
          }
        });
      }
    }

    startTimer(); // Start the timer when the view is built

    return PopScope(
      canPop: false, // Prevent the user from going back
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 200),

                    Text(
                      'VERIFICATION',
                      style: AppTextStyles.MetropolisMedium.copyWith(
                        fontSize: 18,
                        color: const Color(0xFF434343),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Text(
                        'A Verification Code Has Been Sent To Your Phone Number',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.MetropolisRegular.copyWith(
                          fontSize: 13,
                          color: const Color(0xFF858585),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    Pinput(
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: focusedPinTheme,
                      submittedPinTheme: submittedPinTheme,
                      length: 6,
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      showCursor: true,
                      obscureText: true,
                      onChanged: (pin) {
                        controller.otpController.value = pin;
                      },
                      onCompleted: (pin) {
                        controller.otpController.value = pin;
                      },
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
              CustomButton(
                text: 'VERIFY',
                onPressed: () {
                  final verificationId = Get.arguments?['verificationId'] ?? "";
                  final phoneNumber = Get.arguments?['phoneNumber'] ?? "";

                  controller.verifyOTP(verificationId, phoneNumber);
                },
                isLoading: controller.isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
