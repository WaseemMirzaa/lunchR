import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:luncher/app/routes/app_pages.dart';
import 'package:luncher/config/app_colors.dart';
import 'package:luncher/config/app_text_style.dart';
import 'package:luncher/widgets/custom_simple_textfields.dart';
import 'package:luncher/widgets/custom_textfeild.dart';
import 'package:luncher/widgets/reuse_button.dart';

import '../controllers/cafeteria_phone_authenication_controller.dart';

class CafeteriaPhoneAuthenicationView
    extends GetView<CafeteriaPhoneAuthenicationController> {
  const CafeteriaPhoneAuthenicationView({super.key});

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
                      height: 50), // Space between heading and text field

                  const SimpleTextFieldWidget(
                    hintText: 'Mobile No',
                    imagePath: 'assets/icon/call_light.png',
                    keyboardType: TextInputType.phone,
                  ),

                  const SizedBox(
                      height: 20), // Space between text field and button
                ],
              ),
            ),
            // Custom button to submit the email
            CustomButton(
              text: 'CONTINUE AS CAFETERIA OWNER',
              onPressed: () {
                Get.toNamed(Routes.CAFETERIA_PHONE_VERIFICATION);
              },
              isLoading: false.obs, // RxBool for loading state
            ),

            const SizedBox(
              height: 10,
            ),

            // Custom button to submit the email
            CustomButton(
              text: 'CONTINUE AS STAFF',
              onPressed: () {
                Get.toNamed(Routes.STAFF_PHONE_VERIFICATION);
              },
              isLoading: false.obs, // RxBool for loading state
            ),
          ],
        ),
      ),
    );
  }
}
