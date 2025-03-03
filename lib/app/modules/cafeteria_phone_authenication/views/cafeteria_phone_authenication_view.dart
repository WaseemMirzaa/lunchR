import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:luncher/app/routes/app_pages.dart';

import 'package:luncher/config/app_colors.dart';
import 'package:luncher/config/app_text_style.dart';
import 'package:luncher/widgets/custom_simple_textfields.dart';
import 'package:luncher/widgets/reuse_button.dart';

import '../controllers/cafeteria_phone_authenication_controller.dart';

class CafeteriaPhoneAuthenicationView extends GetView<CafeteriaPhoneAuthenicationController> {
  const CafeteriaPhoneAuthenicationView({super.key});

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
                    'PHONE AUTHENTICATION',
                    style: AppTextStyles.MetropolisMedium.copyWith(
                      fontSize: 18,
                      color: const Color(0xFF434343),
                    ),
                  ),

                  const SizedBox(height: 20), // Space between heading and text field

                  Text(
                    'Please Enter Your Phone Number',
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
                ],
              ),
            ),
            // Custom button to submit the email
            Obx(
                  ()=> CustomButton1(
                text: 'CONTINUE AS CAFETERIA OWNER',
                onPressed: () async => await controller.authenticatePhoneNumber(
                  true,
                ),
                isLoading: controller.isLoading.value,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            // Custom button to submit the email
            Obx(
                  ()=> CustomButton1(
                text: 'CONTINUE AS STAFF',
                onPressed: () {
                  Get.toNamed(Routes.STAFF_PHONE_VERIFICATION);
                },

                isLoading: controller.isStaffLoading.value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
