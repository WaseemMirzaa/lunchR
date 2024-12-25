import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luncher/app/modules/parents_history/controllers/parents_history_controller.dart';
import 'package:luncher/config/app_text_style.dart';
import 'package:luncher/widgets/custom_wallet_widget.dart';

import '../controllers/parents_history_list_controller.dart';

class ParentsHistoryListView extends GetView<ParentsHistoryListController> {
  const ParentsHistoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    final historyController = Get.find<ParentsHistoryController>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
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
                  onTap: () {
                    historyController.updateSelectedIndex(1);
                  },
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
                    isShowScan: false,
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
