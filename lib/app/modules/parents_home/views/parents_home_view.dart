import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luncher/config/app_text_style.dart';
import 'package:luncher/widgets/custom_wallet_widget.dart';
import 'package:luncher/widgets/reuse_button.dart';
import '../controllers/parents_home_controller.dart';

class ParentsHomeView extends GetView<ParentsHomeController> {
  const ParentsHomeView({super.key});

  @override
  Widget build(BuildContext context) {
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
              ],
            ),
            const SizedBox(height: 24),
            // Two Wallet Balance Cards
            const WalletBalanceCard(
              isShowScan: false,
            ),
            const SizedBox(height: 24),
            const WalletBalanceCard(
              isShowScan: false,
            ),
            const Spacer(),
            CustomButton(
                text: 'ADD WALLET BALANCE',
                onPressed: () {},
                isLoading: false.obs),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
