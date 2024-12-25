import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:luncher/app/modules/cafeteria_child_verification_home/controllers/cafeteria_child_verification_home_controller.dart';
import 'package:luncher/config/app_text_style.dart';
import 'package:luncher/widgets/custom_wallet_widget.dart';
import 'package:luncher/widgets/reuse_button.dart';

import '../controllers/child_verification_upload_info_controller.dart';

class ChildVerificationUploadInfoView
    extends GetView<ChildVerificationUploadInfoController> {
  const ChildVerificationUploadInfoView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CafeteriaChildVerificationHomeController>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 35),
              child: Align(
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
            ),

            // Settings Title
            Center(
              child: Text(
                'UPLOAD INFO', // Title text
                style: AppTextStyles.MetropolisMedium.copyWith(
                  fontSize: 18,
                  color: const Color(0xFF434343),
                ),
              ),
            ),
            const SizedBox(height: 32), // Spacing between title and list
            // Row with month/year and calendar icon
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '20,July ',
                      style: AppTextStyles.RobotoLight.copyWith(
                        fontSize: 18,
                        color: const Color(0xFF2E2E2E),
                      ),
                    ),
                    TextSpan(
                      text: '2024',
                      style: AppTextStyles.RobotoBold.copyWith(
                        fontSize: 18,
                        color: const Color(0xFF2E2E2E),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Center(
                child: Image.asset(
                  'assets/icon/camera.png', // Change to your image asset
                  width: 75,
                  height: 75,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // First custom Row with text and image
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Upload Student Photo',
                    style: AppTextStyles.MetropolisMedium.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Second custom Row with container, image, and texts
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 227,
                    height: 249,
                    decoration: BoxDecoration(
                      color: Colors.white
                          .withOpacity(0.9), // Optional background color
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        // Image taking 80% of the container height
                        Image.asset(
                          'assets/images/gra.png', // Change to your image asset
                          width: double.infinity,
                          height: 0.85 * 249, // 80% of container height
                          fit: BoxFit.contain,
                        ),
                        // Bottom row with text and price
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Chicken Gravy',
                                style: AppTextStyles.MetropolisMedium.copyWith(
                                  fontSize: 22,
                                ),
                              ),
                              Text(
                                '\$25',
                                style: AppTextStyles.MetropolisMedium.copyWith(
                                  fontSize: 22,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ListView of WalletBalanceCards
            // ignore: prefer_const_constructors
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: const WalletBalanceCard(
                isEdit: false,
                walletDesc: 'Wallet Remaining Balance',
                price: '\$25',
                isShowScan: false,
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            CustomButton(
                text: 'CONFIRM', onPressed: () {}, isLoading: false.obs),

            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
