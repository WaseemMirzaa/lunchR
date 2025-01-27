import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:luncher/app/modules/staff_history/controllers/staff_history_controller.dart';

import 'package:luncher/widgets/custom_wallet_widget.dart';

import '../controllers/staff_history_list_controller.dart';

class StaffHistoryListView extends GetView<StaffHistoryListController> {
  const StaffHistoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    final historyController = Get.find<StaffHistoryController>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // ListView of WalletBalanceCards
          Expanded(
            child: ListView.builder(
              itemCount: 4, // Display 4 items
              padding: const EdgeInsets.only(top: 8), // Reduce the top padding
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: 24,
                    left: 16,
                    right: 16,
                  ), // Adjust the padding as needed
                  child: GestureDetector(
                    onTap: () {
                      historyController.updateSelectedIndex(2);
                    },
                    child: WalletBalanceCard(
                      isEdit: false,
                      price: index == 1 ? '\$870' : '\$250',
                      isType: false,
                      isDuration: false,
                      isStaff: false,
                      isDelivered: true,
                      isDeliveredBy: false,
                      isShowScan: true,
                      isNoImage: false,
                      isPreparing: false,
                      image: 'assets/images/userimg.png',
                      walletDesc: 'Weekly Spending',
                    ),
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
