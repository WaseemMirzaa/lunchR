import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luncher/app/modules/home_settings/controllers/home_settings_controller.dart';
import 'package:luncher/app/modules/parents_history/controllers/parents_history_controller.dart';
import 'package:luncher/config/app_text_style.dart';
import 'package:luncher/widgets/custom_wallet_widget.dart';

import '../controllers/parents_history_list_controller.dart';

class ParentsHistoryListView extends GetView<ParentsHistoryListController> {
  const ParentsHistoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    final historyController = Get.find<HomeSettingsController>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 35),
            child: GestureDetector(
              onTap: () {
                historyController.updateSelectedIndex(0);
              },
              child: Align(
                alignment: Alignment.topLeft,
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

          const SizedBox(
            height: 8,
          ),

          // Settings Title
          Text(
            'HISTORY', // Title text
            style: AppTextStyles.MetropolisMedium.copyWith(
              fontSize: 18,
              color: const Color(0xFF434343),
            ),
          ),
          const SizedBox(height: 32), // Spacing between title and list

          // Row with month/year and calendar icon
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 8), // Added vertical padding
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'July ',
                      style: AppTextStyles.RobotoLight.copyWith(
                        fontSize: 18,
                        color: const Color(0xFF2E2E2E),
                      ),
                    ),
                    Text(
                      '2024',
                      style: AppTextStyles.RobotoBold.copyWith(
                        fontSize: 18,
                        color: const Color(0xFF2E2E2E),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {},
                  child: Image.asset(
                    'assets/icon/calendar.png',
                    height: 20,
                    width: 20,
                  ),
                )
              ],
            ),
          ),

          // ListView of WalletBalanceCards
          Expanded(
            child: ListView.builder(
              itemCount: 4, // Display 4 items
              padding: const EdgeInsets.only(top: 8), // Reduce the top padding
              itemBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.only(
                    bottom: 24,
                    left: 16,
                    right: 16,
                  ), // Adjust the padding as needed
                  child: WalletBalanceCard(
                    isEdit: false,
                    isShowScan: true,
                    isNoImage: true,
                    isDelivered: false,
                    isPreparing: false,
                    isDuration: false,
                    isType: false,
                    isStaff: false,
                    walletDesc: 'Monthly Spending',
                    price: '\$250',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
