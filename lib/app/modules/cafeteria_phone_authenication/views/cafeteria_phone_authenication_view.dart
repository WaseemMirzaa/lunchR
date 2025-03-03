import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:luncher/app/routes/app_pages.dart';

import 'package:luncher/config/app_colors.dart';
import 'package:luncher/config/app_text_style.dart';
import 'package:luncher/widgets/custom_simple_textfields.dart';
import 'package:luncher/widgets/reuse_button.dart';

import '../controllers/cafeteria_phone_authenication_controller.dart';
import 'package:intl_phone_field/intl_phone_field.dart';


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

                  Container(
                    height: 56,
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 30, right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppColors.whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: IntlPhoneField(
                      // disableLengthCheck: true,
                      decoration: InputDecoration(
                        labelText: 'Mobile No',
                        labelStyle: AppTextStyles.MetropolisRegular.copyWith(
                          color: const Color(0xFFB6B7B7),
                          fontSize: 12,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        border: InputBorder.none,
                        counterText: '',
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorText: null,

                      ),
                      initialCountryCode: 'US',
                      onChanged: (phone) {
                        controller.phoneController.text = phone.completeNumber;
                      },
                    ),

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
