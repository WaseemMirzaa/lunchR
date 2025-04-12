import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luncher/config/app_colors.dart';
import 'package:luncher/widgets/custom_textfield_without_suffix.dart';
import 'package:luncher/widgets/reuse_button.dart';
import '../controllers/setting_parent_profile_controller.dart';

class SettingParentProfileView extends GetView<SettingParentProfileController> {
  const SettingParentProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Edit Profile'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
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
              ),
              const SizedBox(height: 24),

              Obx(() => CustomButton1(
                  text: 'UPDATE PROFILE',
                  onPressed: controller.updateProfile,
                  isLoading: controller.isLoading.value))
            ],
          ),
        );
      }),
    );
  }
}
