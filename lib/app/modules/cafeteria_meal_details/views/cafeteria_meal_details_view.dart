import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luncher/config/app_text_style.dart';

import 'package:luncher/widgets/custom_textfield_without_suffix.dart';
import 'package:luncher/widgets/reuse_button.dart';
import '../controllers/cafeteria_meal_details_controller.dart';

class CafeteriaMealDetailsView extends GetView<CafeteriaMealDetailsController> {
  const CafeteriaMealDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 4,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Image.asset("assets/icon/back.png",
                            height: 15, width: 10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'MEAL DETAILS',
                    style: AppTextStyles.MetropolisMedium.copyWith(
                        color: const Color(0xFF434343), fontSize: 18),
                  ),
                ),
                const SizedBox(height: 36),
                SimpleTextFieldWithOutSuffixWidget(
                    controller: controller.nameController,
                    hintText: 'Meal Name'),
                const SizedBox(height: 16),
                SimpleTextFieldWithOutSuffixWidget(
                    controller: controller.availabilityController,
                    hintText: 'Availability'),
                const SizedBox(height: 16),
                SimpleTextFieldWithOutSuffixWidget(
                    controller: controller.priceController, hintText: 'Price'),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () => controller.pickImage(),
                  child: Obx(() {
                    return Container(
                      width: double.infinity,
                      height: 127,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(20), // Apply radius to image
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
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return _buildPlaceholder();
                                    },
                                  )
                                : _buildPlaceholder(),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          CustomButton(
            text: 'SUBMIT',
            onPressed: controller.submitMeal,
            isLoading: controller.isLoading,
          ),
        ],
      ),
    );
  }

  // Placeholder Widget Function
// Placeholder Widget Function
  Widget _buildPlaceholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/icon/camera.png', width: 60, height: 50),
        const SizedBox(height: 10),
        Text(
          'Upload Meal Photo',
          style: AppTextStyles.MetropolisRegular.copyWith(
            fontSize: 12,
            color: const Color(0xFFB6B7B7),
          ),
        ),
      ],
    );
  }
}
