import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:luncher/app/modules/staff_history/controllers/staff_history_controller.dart';
import 'package:luncher/config/app_text_style.dart';
import 'package:luncher/widgets/custom_wallet_widget.dart';
import 'package:luncher/widgets/reuse_button.dart';

import '../controllers/staff_history_detail_controller.dart';

class StaffHistoryDetailView extends GetView<StaffHistoryDetailController> {
  const StaffHistoryDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    final historyController = Get.find<StaffHistoryController>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    historyController.updateSelectedIndex(0);
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

            Center(
              child: Text(
                'History',
                style: AppTextStyles.MetropolisBold.copyWith(
                  fontSize: 18,
                  color: const Color(0xFF434343),
                ),
              ),
            ),

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

            const SizedBox(width: 8),
            Center(
              child: Image.asset(
                'assets/images/userimg.png', // Change to your image asset
                width: 125,
                height: 125,
              ),
            ),

            // First custom Row with text and image
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Student Photo',
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
                    width: 166,
                    height: 183,
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
                          height: 153, // 80% of container height
                          fit: BoxFit.contain,
                        ),
                        // Bottom row with text and price
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Chicken Gravy',
                              style: AppTextStyles.MetropolisMedium.copyWith(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '\$25',
                              style: AppTextStyles.MetropolisMedium.copyWith(
                                fontSize: 16,
                              ),
                            ),
                          ],
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
                price: '\$250',
                isShowScan: true,
                isNoImage: true,
                isPreparing: false,
                isDelivered: false,
                isStaff: false,
                isType: false,
                isDuration: false,
              ),
            ),

            CustomButton(
                text: 'Confirm', onPressed: () {}, isLoading: false.obs),
            SizedBox(
              height: 16,
            )
          ],
        ),
      ),
    );
  }
}
