import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luncher/config/app_colors.dart';
import 'package:luncher/config/app_text_style.dart';
import 'package:luncher/widgets/custom_textfeild.dart';
import 'package:luncher/widgets/reuse_button.dart';
import '../controllers/phone_authentication_controller.dart';

class PhoneAuthenticationView extends GetView<PhoneAuthenticationController> {
  const PhoneAuthenticationView({super.key});


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 200),

              // Heading
              Text(
                'PHONE AUTHENTICATION',
                style: AppTextStyles.MetropolisMedium.copyWith(
                  fontSize: 18,
                  color: const Color(0xFF434343),
                ),
              ),
              const SizedBox(height: 20),

              // Description
              Text(
                'Please Enter Your Phone Number',
                textAlign: TextAlign.center,
                style: AppTextStyles.MetropolisRegular.copyWith(
                  fontSize: 13,
                  color: const Color(0xFF858585),
                ),
              ),
              const SizedBox(height: 20),

              // Phone number field
              TextFieldWidget(
                text: 'Mobile No',
                path: 'assets/icon/call_light.png',
                keyboardType: TextInputType.phone,
                textController: controller.phoneController,
              ),
              const SizedBox(height: 30),

              // Continue button
              CustomButton1(
                text: 'CONTINUE',
                onPressed: () async =>
                    await controller.authenticatePhoneNumber(),
                isLoading: controller.isLoading.value,
                gradientColors: const [Colors.orange, Colors.red],
                height: 60.0,
                borderRadius: 12.0,
                fontSize: 18.0,
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
