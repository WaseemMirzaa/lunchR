import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:luncher/app/routes/app_pages.dart';
import 'package:luncher/config/app_colors.dart';
import 'package:luncher/config/app_text_style.dart';
import 'package:luncher/widgets/custom_textfeild.dart';
import 'package:luncher/widgets/reuse_button.dart';

import '../controllers/phone_authentication_controller.dart';

class PhoneAuthenticationView extends GetView<PhoneAuthenticationController> {
  const PhoneAuthenticationView({super.key});

  @override
  Widget build(BuildContext context) {
    // Define the controller for the email text field
    final TextEditingController phoneController = TextEditingController();

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const SizedBox(height: 60), // Padding to push content down

                const SizedBox(height: 140), // Space between logo and form

                // Heading text
                Text(
                  'PHONE AUTHENTICATION',
                  style: AppTextStyles.MetropolisMedium.copyWith(
                    fontSize: 18,
                    color: const Color(0xFF434343),
                  ),
                ),

                const SizedBox(
                    height: 20), // Space between heading and text field

                Text(
                  'Please Enter Your Phone Number',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.MetropolisRegular.copyWith(
                    fontSize: 13,
                    color: const Color(0xFF858585),
                  ),
                ),

                const SizedBox(
                    height: 20), // Space between heading and text field

                // Email TextField widget
                TextFieldWidget(
                  text: 'Mobile No',
                  path: 'assets/icon/call_light.png',
                  keyboardType: TextInputType.phone,
                  textController: phoneController,
                ),

                const SizedBox(
                    height: 30), // Space between text field and button

                // Custom button to submit the email
                CustomButton(
                  text: 'CONTINUE',
                  onPressed: () {
                    Get.toNamed(Routes.PHONE_VERIFICATION);
                  },
                  isLoading: false.obs, // RxBool for loading state
                  gradientColors: const [Colors.orange, Colors.red],
                  height: 60.0,
                  borderRadius: 12.0,
                  fontSize: 18.0,
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                ),

                const SizedBox(
                    height: 20), // Space between button and footer text
              ],
            ),
          ),
        ),
      ),
    );
  }

}
