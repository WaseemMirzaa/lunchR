import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:luncher/app/modules/cafeteria_child_verification_home/controllers/cafeteria_child_verification_home_controller.dart';
import 'package:luncher/app/routes/app_pages.dart';
import 'package:luncher/config/app_colors.dart';
import 'package:luncher/config/app_text_style.dart';
import 'package:luncher/widgets/custom_textfeild.dart';
import 'package:luncher/widgets/custom_textfield_without_suffix.dart';
import 'package:luncher/widgets/reuse_button.dart';

import '../controllers/cafeteria_child_verification_controller.dart';

class CafeteriaChildVerificationView
    extends GetView<CafeteriaChildVerificationController> {
  const CafeteriaChildVerificationView({super.key});
  @override
  Widget build(BuildContext context) {
    // Define the controller for the email text field
    final TextEditingController phoneController = TextEditingController();
    final controller = Get.find<CafeteriaChildVerificationHomeController>();

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const SizedBox(height: 100), // Padding to push content down

                // Heading text
                Text(
                  'IDENTIFICATION',
                  style: AppTextStyles.MetropolisMedium.copyWith(
                    fontSize: 18,
                    color: const Color(0xFF434343),
                  ),
                ),

                const SizedBox(
                    height: 20), // Space between heading and text field

                Text(
                  'Enter Children School Id',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.MetropolisRegular.copyWith(
                    fontSize: 13,
                    color: const Color(0xFF858585),
                  ),
                ),

                const SizedBox(height: 60), // Padding to push content down

                // // Email TextField widget
                // TextFieldWidget(
                //   text: 'Child School ID',
                //   isSuffix: true,
                //   keyboardType: TextInputType.phone,
                //   textController: phoneController,
                // ),

                const SimpleTextFieldWithOutSuffixWidget(hintText: 'Child School ID'),

                const SizedBox(
                    height: 20), // Space between text field and button

                // Custom button to submit the email
                CustomButton(
                  text: 'IDENTIFY',
                  onPressed: () {
                    controller.updateSelectedIndex(1);
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
