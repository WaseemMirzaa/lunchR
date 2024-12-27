import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:luncher/config/app_text_style.dart';
import 'package:luncher/widgets/custom_textfeild.dart';

import 'package:luncher/widgets/reuse_button.dart';
import '../controllers/cafeteria_cafeteria_detail_controller.dart';

class CafeteriaCafeteriaDetailView
    extends GetView<CafeteriaCafeteriaDetailController> {
  const CafeteriaCafeteriaDetailView({super.key});

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'CAFETERIA DETAILS',
                    style: AppTextStyles.MetropolisMedium.copyWith(
                      color: const Color(0xFF434343),
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Obx(() => GestureDetector(
                      onTap: () => _showImagePickerBottomSheet(context),
                      child: Container(
                        width: double.infinity,
                        height: 107,
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
                        child: controller.selectedImage.value != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.file(
                                  File(controller.selectedImage.value!),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Image.asset(
                                      'assets/icon/camera.png',
                                      width: 60,
                                      height: 50,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Upload Meal Photo',
                                    style: AppTextStyles.MetropolisRegular
                                        .copyWith(
                                      fontSize: 12,
                                      color: const Color(0xFFB6B7B7),
                                    ),
                                  )
                                ],
                              ),
                      ),
                    )),
                const SizedBox(height: 20),
                TextFieldWidget(
                  isSuffix: true,
                  text: 'Cafeteria Name',
                  textController: controller.mealController,
                ),
                const SizedBox(height: 10),
                TextFieldWidget(
                  isSuffix: true,
                  text: 'School / Collage Name',
                  textController: controller.schoolController,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          CustomButton(
            text: 'CONTINUE',
            onPressed: controller.uploadDataToFirestore,
            isLoading: controller.isLoading,
          )
        ],
      ),
    );
  }

  void _showImagePickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Take a Photo'),
                onTap: () {
                  controller.pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  controller.pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
