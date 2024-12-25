import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luncher/config/app_colors.dart';
import 'package:luncher/config/app_images.dart';
import 'package:luncher/config/app_text_style.dart';
import 'package:luncher/widgets/reuse_button.dart';
import 'package:luncher/widgets/selection_tile.dart';

import '../controllers/selection_controller.dart';

class SelectionView extends GetView<SelectionController> {
  const SelectionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.gradientStartColor,
              AppColors.gradientEndColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const Spacer(flex: 8), // Keeps LUNCH R centered at the top
              Center(
                child: Text(
                  'LunchR',
                  style: AppTextStyles.AltoysItalic.copyWith(
                    fontSize: 45,
                    color: AppColors.whiteColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(
                  flex:
                      8), // Increased the flex even more to push "TYPE SELECTION" further down

              // 'TYPE SELECTION' text positioned much further below the center
              Text(
                'TYPE SELECTION',
                style: AppTextStyles.MetropolisBold.copyWith(
                  fontSize: 22,
                  color: AppColors.whiteColor, // Keep text white
                ),
              ),
              const SizedBox(height: 60),

              // Additional spacing between the text and the row

              const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SelectionTile(
                    imgPath: AppImages.parent,
                    text: 'Parents',
                    isParent: true,
                  ),
                  SizedBox(width: 20),
                  SelectionTile(
                    imgPath: AppImages.cafe,
                    imageHeight: 86,
                    imageWidth: 86,
                    isParent: false,
                    text: 'Cafeteria',
                  ),
                ],
              ),
              const Spacer(flex: 3), // Balanced space after the tiles

              CustomButton(
                isBackColor: false,
                text: 'CONTNUE',
                fontSize: 16,
                onPressed: () {
                  // Get.toNamed(Routes.PHONE_AUTHENTICATION);
                },
                isLoading: false.obs,
              ),
              const Spacer(flex: 1), // Space below the button
            ],
          ),
        ),
      ),
    );
  }
}
