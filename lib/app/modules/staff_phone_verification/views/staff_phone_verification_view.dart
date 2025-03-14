import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:luncher/app/modules/staff_phone_verification/controllers/staff_phone_verification_controller.dart';
import 'package:luncher/config/app_colors.dart';
import 'package:luncher/config/app_text_style.dart';
import 'package:luncher/widgets/custom_password_text_field.dart';
import 'package:luncher/widgets/custom_simple_textfields.dart';
import 'package:luncher/widgets/reuse_button.dart';

class StaffPhoneAuthenticationView extends StatelessWidget {
  StaffPhoneAuthenticationView({super.key});

  final StaffPhoneVerificationController controller = Get.put(StaffPhoneVerificationController());

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
                  const SizedBox(height: 200),

                  Text(
                    'STAFF AUTHENTICATION',
                    style: AppTextStyles.MetropolisMedium.copyWith(
                      fontSize: 18,
                      color: const Color(0xFF434343),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    'Please Enter Your Phone Number and Password!',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.MetropolisRegular.copyWith(
                      fontSize: 13,
                      color: const Color(0xFF858585),
                    ),
                  ),

                  const SizedBox(height: 50),

                  // Phone number field
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
                        ),
                        initialCountryCode: 'PK',
                        onChanged: (phone) {
                          controller.phoneController.text = phone.completeNumber;
                        },
                        autovalidateMode:     AutovalidateMode.disabled     ),
                  ),
                  // SimpleTextFieldWidget(
                  //   hintText: 'Mobile No',
                  //   imagePath: 'assets/icon/call_light.png',
                  //   keyboardType: TextInputType.phone,
                  //   controller: controller.phoneController,
                  // ),
                  const SizedBox(height: 20),
                  CustomPasswordFieldWidget(
                    hintText: "Password",
                    controller: controller.passwordController,
                    isVisible: false,
                  ),
                  // SimpleTextFieldWidget(
                  //   hintText: 'Password',
                  //   imagePath: 'assets/icon/unlock.png',
                  //   keyboardType: TextInputType.visiblePassword,
                  //   controller: controller.passwordController,
                  // ),
                  const SizedBox(height: 50),
                ],
              ),
            ),

            Obx(
                  () => CustomButton1(
                text: 'CONTINUE',
                onPressed: () async => controller.staffLogin(),
                isLoading: controller.isLoading.value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

