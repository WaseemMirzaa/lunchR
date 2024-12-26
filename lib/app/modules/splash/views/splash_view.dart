import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luncher/app/modules/splash/controllers/splash_controller.dart';
import 'package:luncher/app/routes/app_pages.dart';
import 'package:luncher/config/app_colors.dart';
import 'package:luncher/config/app_text_style.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    // // Auto navigate after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed(Routes.SELECTION); // This will navigate to nextScreen
    });

    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.gradientStartColor,
                  AppColors.gradientEndColor,
                ],
              ),
            ),
          ),
          // Centered text
          Padding(
            padding: const EdgeInsets.only(bottom: 200),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'LunchR',
                    style: AppTextStyles.MetropolisRegularItalic.copyWith(
                      color: AppColors.whiteColor,
                      fontSize: 45
                    ),
                  ),
                  Text(
                    'Tasty & Healthy',
                    style: AppTextStyles.MetropolisRegular.copyWith(
                      fontSize: 16,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Positioned image at the right-end bottom
          Positioned(
            bottom: -53, // Position it at the bottom
            right: -53, // Align it to the right edge
            left: 0,

            child: Image.asset(
              'assets/images/splash.png', // Replace with your image path
              // width: 420, // Adjust the image width
              // height: 420, // Adjust the image height
              fit: BoxFit.cover, // Ensure the image maintains its aspect ratio
            ),
          ),
        ],
      ),
    );
  }
}
