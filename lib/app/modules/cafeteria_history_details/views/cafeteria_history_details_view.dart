import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:luncher/config/app_text_style.dart';
import 'package:luncher/widgets/custom_wallet_widget.dart';

import '../controllers/cafeteria_history_details_controller.dart';

class CafeteriaHistoryDetailsView
    extends GetView<CafeteriaHistoryDetailsController> {
  const CafeteriaHistoryDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                price: '\$250',
                isShowScan: false,
              ),
            )
          ],
        ),
      ),
    );
  }
}
