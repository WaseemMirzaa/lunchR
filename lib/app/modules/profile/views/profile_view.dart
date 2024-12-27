import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:luncher/app/modules/home_settings/controllers/home_settings_controller.dart';
import 'package:luncher/config/app_text_style.dart';

import 'package:luncher/widgets/custom_textfield_without_suffix.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {

    final controller = Get.find<HomeSettingsController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Profile Picture

            const SizedBox(
              height: 40,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  controller.updateSelectedIndex(0);
                },
                child: Container(
                  height: 35,
                  width: 35,
                  margin: const EdgeInsets.only(
                      top: 16), // Add some margin if needed
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
            const SizedBox(
              height: 20,
            ),

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

            const SizedBox(height: 10),

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

            const SizedBox(height: 10),

            // Greeting Text
            Text(
              "Hi there Emilia!",
              style: AppTextStyles.MetropolisBold.copyWith(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 40),
            const SimpleTextFieldWithOutSuffixWidget(
                hintText: 'School/Collage Name')
          ],
        ),
      ),
    );
  }
}
