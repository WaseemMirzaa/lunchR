import 'package:flutter/material.dart';
import 'package:luncher/config/app_text_style.dart';

class WalletBalanceCard extends StatelessWidget {
  final bool isEdit; // Parameter to control the visibility of "Edit" text
  final String walletDesc;
  final bool isShowScan;
  final String price;
  final String image;

  // Constructor with default value for isEdit
  const WalletBalanceCard(
      {Key? key,
      this.isEdit = true,
      this.walletDesc = 'Wallet balance',
      this.image = 'assets/icon/scan.png',
      this.price = '\$25',
      this.isShowScan = true})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 113,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 6), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        children: [
          // Profile image wrapped with Container
          Column(
            mainAxisAlignment: MainAxisAlignment.start, // Align image to top
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: const Offset(0, 3), // shadow position
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  radius: 30,
                  backgroundImage: const AssetImage(
                      'assets/images/icecream.png'), // Replace with your image asset
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),

          // Details Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Children Name",
                      style: AppTextStyles.MetropolisMedium.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    if (isEdit)
                      Text(
                        "Edit",
                        style: AppTextStyles.MetropolisRegular.copyWith(
                          fontSize: 12,
                          color: const Color(0xFFFF9A0D),
                        ),
                      ),
                  ],
                ),
                Text(
                  "Collage / School Name",
                  style: AppTextStyles.MetropolisRegular.copyWith(
                      fontSize: 12, color: const Color(0xFF858585)),
                ),
                Text(
                  "Child School ID",
                  style: AppTextStyles.MetropolisRegular.copyWith(
                      fontSize: 12, color: const Color(0xFF858585)),
                ),
                Row(
                  children: [
                    Text(
                      "Type: ",
                      style: AppTextStyles.MetropolisRegular.copyWith(
                          fontSize: 12, color: Colors.black),
                    ),
                    Text(
                      "Wallet Balance",
                      style: AppTextStyles.MetropolisRegular.copyWith(
                          fontSize: 12, color: const Color(0xFF858585)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Duration: ",
                      style: AppTextStyles.MetropolisRegular.copyWith(
                          fontSize: 12, color: Colors.black),
                    ),
                    Text(
                      "Weekly",
                      style: AppTextStyles.MetropolisRegular.copyWith(
                          fontSize: 12, color: const Color(0xFF858585)),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Vertical Divider
          Container(
            width: 1,
            color: Colors.black.withOpacity(0.1),
            margin: const EdgeInsets.only(left: 6, right: 10),
          ),

          // Wallet Balance Section
          isShowScan
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 8),

                    Image.asset(
                      image,
                      width: 36,
                      height: 36,
                    ),

                    const SizedBox(height: 8),
                    // Divider
                    Container(
                      width: 40, // Adjust as needed
                      height: 1,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(height: 8),
                    const SizedBox(height: 4),
                    Text(
                      price,
                      style: AppTextStyles.MetropolisMedium.copyWith(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      walletDesc,
                      style: AppTextStyles.MetropolisMedium.copyWith(
                        fontSize: 6,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center, // Center the second line
                    )
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: walletDesc == 'Wallet Remaining Balance'
                          ? const EdgeInsets.only(left: 0)
                          : const EdgeInsets.only(left: 12),
                      child: Text(
                        price,
                        style: AppTextStyles.MetropolisMedium.copyWith(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      walletDesc == 'Wallet Remaining Balance'
                          ? '${walletDesc.split(' ').take(2).join(' ')}\n${walletDesc.split(' ').skip(2).join(' ')}'
                          : walletDesc,
                      style: AppTextStyles.MetropolisMedium.copyWith(
                        fontSize: 6,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center, // Center the second line
                    )
                  ],
                ),
        ],
      ),
    );
  }
}
