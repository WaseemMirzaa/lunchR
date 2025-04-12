import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luncher/config/app_colors.dart';
import 'package:luncher/widgets/custom_button.dart';
import 'package:luncher/widgets/custom_textfield_without_suffix.dart';
import '../controllers/staff_setting_profile_controller.dart';

class StaffSettingProfileView extends GetView<StaffSettingProfileController> {
  const StaffSettingProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Edit Profile',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Profile Image
              Center(
                child: GestureDetector(
                  onTap: controller.pickImage,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        backgroundImage: controller.selectedImage.value != null
                            ? FileImage(controller.selectedImage.value!)
                            : controller.currentImageUrl.value != null
                                ? NetworkImage(controller.currentImageUrl.value!)
                                : null,
                        child: (controller.selectedImage.value == null &&
                                controller.currentImageUrl.value == null)
                            ? const Icon(Icons.person, size: 50)
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: AppColors.hintText,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),

              SimpleTextFieldWithOutSuffixWidget(
                controller: controller.nameController,
                hintText: 'Staff Name',
              ),
              const SizedBox(height: 24),

              CustomButton1(
                text: 'UPDATE PROFILE',
                onPressed: controller.isLoading.value ? null : () => controller.updateProfile(),
                isLoading: controller.isLoading.value,
              )
            ],
          ),
        );
      }),
    );
  }
}