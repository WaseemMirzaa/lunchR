import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:luncher/app/modules/cafeteria_home_settings/controllers/cafeteria_home_settings_controller.dart';
import 'package:luncher/config/app_text_style.dart';
import 'package:luncher/config/validation.dart';
import 'package:luncher/models/cefeteria_admin/staff_model.dart';
import 'package:luncher/widgets/custom_back_button.dart';
import 'package:luncher/widgets/custom_password_text_field.dart';
import 'package:luncher/widgets/custom_textfield_without_suffix.dart';
import 'package:luncher/widgets/reuse_button.dart';

import '../controllers/cafeteria_add_staff_controller.dart';

class CafeteriaAddStaffView extends GetView<CafeteriaAddStaffController> {
  // Constructor: Initialize both 'isEdit' and 'staffModelL' from Get.arguments
  const CafeteriaAddStaffView({super.key});
  @override
  Widget build(BuildContext context) {
    // final addStaffController = Get.find<CafeteriaHomeSettingsController>();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Profile Picture

              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                        // addStaffController.updateSelectedIndex(0);
                      },
                      child: Container(
                        height: 35,
                        width: 35,
                        margin: const EdgeInsets.only(top: 16), // Add some margin if needed
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 4,
                              spreadRadius: 2,
                            ),
                          ],
                          color: Colors.white, // Background color for the container
                        ),
                        child: Center(
                          child: Image.asset(
                            "assets/icon/back.png",
                            height: 15, // Set the height to 15
                            width: 10, // Set the width to 15
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Add Staff",
                    style: AppTextStyles.MetropolisBold.copyWith(
                      fontSize: 18,
                      color: const Color(0xFF434343),
                    ),
                  ),
                  const SizedBox(),
                ],
              ),
              const SizedBox(height: 35),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Obx(
                            () => Container(
                              width: 102,
                              height: 102,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3, // Border with a width of 3
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        Colors.black.withOpacity(0.1), // Shadow color with opacity
                                    blurRadius: 5, // Blur effect
                                    spreadRadius: 2, // Spread radius
                                    offset: const Offset(0, 1), // Position of the shadow (x, y)
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: controller.selectedImage.value != null
                                    ? Image.file(
                                        controller.selectedImage.value!,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 127,
                                      )
                                    : controller.imageUrl.value.isNotEmpty
                                        ? Image.network(
                                            controller.imageUrl.value,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: 127,
                                            loadingBuilder: (context, child, loadingProgress) {
                                              if (loadingProgress == null) return child;
                                              return const Center(
                                                  child: CircularProgressIndicator());
                                            },
                                            errorBuilder: (context, error, stackTrace) {
                                              return _buildPlaceholder();
                                            },
                                          )
                                        : _buildPlaceholder(),
                                // Image.asset(
                                //   'assets/images/userimg.png', // Replace with the actual image URL
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: CustomBackButton(
                                  onTap: () => controller.pickImage(),
                                  widget: const Icon(Icons.add)))
                        ],
                      ),
                      // if (isEdit) const SizedBox(height: 10),
                      // if (isEdit)
                      //   Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       const Icon(
                      //         Icons.edit,
                      //         color: Color(0xFFFF9A0D),
                      //         size: 16,
                      //       ),
                      //
                      //       const SizedBox(width: 5),
                      //
                      //       // Edit Profile
                      //       GestureDetector(
                      //         onTap: () {
                      //           // Handle edit profile action
                      //         },
                      //         child: Text(
                      //           "Edit Profile",
                      //           style: AppTextStyles.MetropolisMedium.copyWith(
                      //             color: const Color(0xFFFF9A0D),
                      //             fontSize: 12,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      const SizedBox(height: 20),
                      SimpleTextFieldWithOutSuffixWidget(
                        hintText: 'Staff Name',
                        controller: controller.nameController,
                      ),
                      const SizedBox(height: 20),
                      SimpleTextFieldWithOutSuffixWidget(
                        // validator: Validator.isValidEmail,
                        hintText: 'Email',
                        controller: controller.emailController,
                      ),
                      const SizedBox(height: 20),
                      SimpleTextFieldWithOutSuffixWidget(
                        hintText: 'Phone',
                        keyboardType: TextInputType.number,
                        controller: controller.phoneController,
                      ),
                      const SizedBox(height: 20),
                      // SimpleTextFieldWithOutSuffixWidget(
                      //   hintText: 'Password',
                      //   controller: controller.passwordController,
                      //   isVisible: true,
                      // ),
                      CustomPasswordFieldWidget(
                        hintText: "Password",
                        controller: controller.passwordController,
                        isVisible: false,
                      ),
                      const SizedBox(height: 20),
                      Obx(
                        () => CustomButton1(
                            text: 'Continue',
                            onPressed: () async {
                              await controller.addStaffData();
                              // addStaffController.updateSelectedIndex(0);
                            },
                            isLoading: controller.isLoading.value),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Placeholder Widget Function
  Widget _buildPlaceholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/icon/camera.png',
          width: 40,
        ),
      ],
    );
  }
}
