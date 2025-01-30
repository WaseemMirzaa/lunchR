import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:get/get.dart';
import 'package:luncher/app/routes/app_pages.dart';
import 'package:luncher/config/app_text_style.dart';
import 'package:luncher/widgets/custom_wallet_widget.dart';
import 'package:luncher/widgets/reuse_button.dart';
import '../controllers/parents_home_controller.dart';

class ParentsHomeView extends GetView<ParentsHomeController> {
  const ParentsHomeView({super.key});




  @override
  Widget build(BuildContext context) {
    final switchController = ValueNotifier<bool>(true); // Controller for switch
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Total Wallet Balance Section
            const SizedBox(
              height: 90,
            ),
            Column(
              children: [
                Text(
                  "\$25",
                  style: AppTextStyles.PoppinsMedium.copyWith(
                    fontSize: 40,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Total Wallet Balance",
                  style: AppTextStyles.MetropolisMedium.copyWith(
                    fontSize: 16,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Enable Monthly Reload",
                      style: AppTextStyles.MetropolisMedium.copyWith(
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 8),
                    AdvancedSwitch(
                      activeColor: Colors.green,
                      inactiveColor: Colors.grey,
                      controller: switchController,
                      width: 27,
                      height: 12,
                      initialValue: true,
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Two Wallet Balance Cards
            const WalletBalanceCard(
              isShowScan: false,
              isDelivered: false,
              isDuration: false,
              isNoImage: false,
              isPreparing: false,
              isType: false,
              isDeliveredBy: false,
              isStaff: false,
            ),
            const SizedBox(height: 24),
            const WalletBalanceCard(
              isShowScan: false,
              isDelivered: false,
              isDuration: false,
              isNoImage: false,
              isPreparing: false,
              isDeliveredBy: false,
              isType: false,
              isStaff: false,
            ),
            const SizedBox(height: 16),

            CustomButton(
                text: 'ADD WALLET BALANCE',
                onPressed: () {
                  Get.toNamed(Routes.PARENTS_ADD_WALLET);
                },
                isLoading: false.obs),
            const SizedBox(height: 16),
            CustomButton(
                text: 'ADD CHILD',
                onPressed: () {
                  Get.toNamed(Routes.PARENTS_CHILDREN_DETAILS);
                },
                isLoading: false.obs),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
