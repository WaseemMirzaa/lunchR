
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:luncher/app/modules/staff_phone_verification/controllers/staff_phone_verification_controller.dart';
import 'package:luncher/config/app_colors.dart';
import 'package:luncher/config/app_text_style.dart';
import 'package:luncher/widgets/custom_simple_textfields.dart';
import 'package:luncher/widgets/reuse_button.dart';

class StaffPhoneAuthenticationView extends GetView<StaffPhoneVerificationController> {
  const StaffPhoneAuthenticationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 200), // Space between logo and form

                  // Heading text
                  Text(
                    'STAFF AUTHENTICATION',
                    style: AppTextStyles.MetropolisMedium.copyWith(
                      fontSize: 18,
                      color: const Color(0xFF434343),
                    ),
                  ),

                  const SizedBox(height: 20), // Space between heading and text field

                  Text(
                    'Please Enter Your Phone Number and Password!',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.MetropolisRegular.copyWith(
                      fontSize: 13,
                      color: const Color(0xFF858585),
                    ),
                  ),

                  const SizedBox(height: 50), // Space between heading and text field

                  SimpleTextFieldWidget(
                    hintText: 'Mobile No',
                    imagePath: 'assets/icon/call_light.png',
                    keyboardType: TextInputType.phone,
                    controller: controller.phoneController,
                  ),
                  const SizedBox(height: 20), // Space between text field and button

                   SimpleTextFieldWidget(
                    hintText: 'Password',
                    imagePath: 'assets/icon/unlock.png',
                    keyboardType: TextInputType.phone,
                    controller: controller.passwordController,
                  ),
                  const SizedBox(height: 50), // Space between text field and button
                ],
              ),
            ),




            // Custom button to submit the email
            Obx(
              ()=> CustomButton1(
                text: 'CONTINUE',

                onPressed: () async =>  controller.staffLogin(),
                isLoading: controller.isLoading.value,
              ),
            ),
          ],
        ),
      ),
    );

  }
}

// import 'package:flutter/material.dart';
//
// import 'package:get/get.dart';
// import 'package:luncher/app/modules/staff_phone_verification/controllers/staff_phone_verification_controller.dart';
//
// import 'package:luncher/config/app_colors.dart';
// import 'package:luncher/config/app_text_style.dart';
// import 'package:luncher/widgets/reuse_button.dart';
// import 'package:pinput/pinput.dart';
//
// class StaffPhoneVerificationView
//     extends GetView<StaffPhoneVerificationController> {
//   const StaffPhoneVerificationView({super.key});
//   @override
//   Widget build(BuildContext context) {
//     Rx<int> timer = 45.obs; // Timer for 1 minute
//     RxBool isTimerRunning = true.obs;
//
//     final defaultPinTheme = PinTheme(
//       width: 56,
//       height: 56,
//       textStyle: AppTextStyles.PoppinsRegular.copyWith(
//         fontSize: 33,
//         color: const Color(0xFF858585),
//       ),
//       decoration: BoxDecoration(
//         color: Colors.white, // White background color
//         border: Border.all(
//           color: Colors.white, // Border color
//           width: 3, // Border width
//         ),
//         borderRadius: BorderRadius.circular(40), // Rounded corners
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.2), // Shadow color
//             blurRadius: 6, // Blur radius for the shadow
//             offset: const Offset(0, 3), // Shadow offset
//           ),
//         ],
//       ),
//     );
//
//     final focusedPinTheme = defaultPinTheme.copyDecorationWith(
//       border: Border.all(
//         color: Colors.white, // Keep the white border when focused
//       ),
//       borderRadius: BorderRadius.circular(40), // Maintain rounded corners
//       boxShadow: [
//         BoxShadow(
//           color: Colors.black
//               .withOpacity(0.3), // Slightly stronger shadow on focus
//           blurRadius: 8, // Increase blur radius for the shadow
//           offset: const Offset(0, 4), // Shadow offset for focus state
//         ),
//       ],
//     );
//
//     final submittedPinTheme = defaultPinTheme.copyDecorationWith(
//       color: Colors.white, // Maintain white background
//       boxShadow: [
//         BoxShadow(
//           color: Colors.black
//               .withOpacity(0.2), // Consistent shadow for submitted state
//           blurRadius: 6,
//           offset: const Offset(0, 3),
//         ),
//       ],
//     );
//
//     // Start timer when the screen is loaded
//     void startTimer() {
//       if (isTimerRunning.value) {
//         Future.delayed(const Duration(seconds: 1), () {
//           if (timer.value > 0) {
//             timer.value--;
//             startTimer();
//           } else {
//             isTimerRunning.value = false; // Stop the timer after 60 seconds
//           }
//         });
//       }
//     }
//
//     startTimer(); // Start the timer when the view is built
//
//     return PopScope(
//       canPop: false, // Prevent the user from going back
//       child: Scaffold(
//         backgroundColor: AppColors.whiteColor,
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: Column(
//               children: [
//                 const SizedBox(height: 60), // Padding to push content down
//
//                 const SizedBox(height: 140), // Space between logo and form
//
//                 // Heading text
//                 Text(
//                   'VERIFICATION',
//                   style: AppTextStyles.MetropolisMedium.copyWith(
//                     fontSize: 18,
//                     color: const Color(0xFF434343),
//                   ),
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 50),
//                   child: Text(
//                     'A Verification Code Has Been Sent On To Your Phone Number',
//                     textAlign: TextAlign.center,
//                     style: AppTextStyles.MetropolisRegular.copyWith(
//                       fontSize: 13,
//                       color: const Color(0xFF858585),
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 40), // Space between text and OTP field
//
//                 Pinput(
//                   defaultPinTheme: defaultPinTheme,
//                   focusedPinTheme: focusedPinTheme,
//                   submittedPinTheme: submittedPinTheme,
//                   length: 6,
//                   pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
//                   showCursor: true,
//                   onChanged: (pin) {
//                     controller.otpController.value = pin; // Final OTP value
//                   },
//                   onCompleted: (pin) {
//                     controller.otpController.value = pin; // Final OTP value
//
//                     // Check if the entered PIN is 000000
//                     // if (pin == '000000') {
//                     //   // Navigate to the cafeteria section
//                     //   Get.offAllNamed(
//                     //       '/cafeteria');
//                     // }
//                   },
//                   mainAxisAlignment: MainAxisAlignment
//                       .spaceEvenly, // Adds even spacing between boxes
//                 ),
//
//                 const SizedBox(
//                   height: 30,
//                 ),
//
//                 // Verify Button
//                 CustomButton(
//                   text: 'VERIFY',
//                   onPressed: () {
//                     final verificationId = Get.arguments;
//                     controller.verifyOTP(verificationId);
//                   },
//                   isLoading: controller.isLoading,
//                   // RxBool for loading state
//                   gradientColors: const [Colors.orange, Colors.red],
//                   height: 60.0,
//                   borderRadius: 12.0,
//                   fontSize: 18.0,
//                   padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
