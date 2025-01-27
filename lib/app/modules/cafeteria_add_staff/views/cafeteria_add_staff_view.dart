import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:luncher/app/modules/cafeteria_home_settings/controllers/cafeteria_home_settings_controller.dart';
import 'package:luncher/app/modules/home_settings/controllers/home_settings_controller.dart';
import 'package:luncher/config/app_text_style.dart';
import 'package:luncher/widgets/custom_textfield_without_suffix.dart';
import 'package:luncher/widgets/reuse_button.dart';

import '../controllers/cafeteria_add_staff_controller.dart';

class CafeteriaAddStaffView extends GetView<CafeteriaAddStaffController> {
  final bool isEdit; // Parameter to control edit functionality
  const CafeteriaAddStaffView({super.key, this.isEdit = false});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CafeteriaHomeSettingsController>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Profile Picture

                SizedBox(height: 80),

                Text(
                  isEdit ? "Staff Profile" : "Add Staff",
                  style: AppTextStyles.MetropolisBold.copyWith(
                    fontSize: 18,
                    color: Color(0xFF434343),
                  ),
                ),
                SizedBox(height: 35),

                Container(
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
                        color: Colors.black
                            .withOpacity(0.1), // Shadow color with opacity
                        blurRadius: 5, // Blur effect
                        spreadRadius: 2, // Spread radius
                        offset: Offset(0, 1), // Position of the shadow (x, y)
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/userimg.png', // Replace with the actual image URL
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                if (isEdit) const SizedBox(height: 10),

                if (isEdit)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.edit,
                        color: Color(0xFFFF9A0D),
                        size: 16,
                      ),

                      SizedBox(width: 5),

                      // Edit Profile
                      GestureDetector(
                        onTap: () {
                          // Handle edit profile action
                        },
                        child: Text(
                          "Edit Profile",
                          style: AppTextStyles.MetropolisMedium.copyWith(
                            color: Color(0xFFFF9A0D),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),

                if (isEdit) const SizedBox(height: 10),

                const SizedBox(height: 20),
                const SimpleTextFieldWithOutSuffixWidget(
                    hintText: 'Staff Name'),
                const SizedBox(height: 20),
                const SimpleTextFieldWithOutSuffixWidget(hintText: 'Email'),
                const SizedBox(height: 20),
                const SimpleTextFieldWithOutSuffixWidget(hintText: 'Phone'),
                const SizedBox(height: 20),
                const SimpleTextFieldWithOutSuffixWidget(hintText: 'Password'),
                const SizedBox(height: 20),
              ],
            ),
          ),
          CustomButton(
              text: isEdit ? 'Save' : 'Continue',
              onPressed: () {
                controller.updateSelectedIndex(3);
              },
              isLoading: false.obs)
        ],
      ),
    );
  }
}
