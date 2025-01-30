import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:luncher/config/app_text_style.dart';

import '../app/routes/app_pages.dart';

class WalletBalanceCard extends StatelessWidget {
  final bool isEdit; // Parameter to control the visibility of "Edit" text
  final String walletDesc;
  final bool isShowScan;
  final String price;
  final String image;
  final bool isType;
  final bool isDuration;
  final bool isStaff;
  final bool isPreparing;
  final bool isDelivered;
  final bool isDeliveredBy;
  final bool isNoImage;

  // Constructor with default value for isEdit
  const WalletBalanceCard(
      {Key? key,
      this.isEdit = true,
      this.isType = true,
      this.isDeliveredBy = true,
      this.isDuration = true,
      this.isNoImage = true,
      this.isPreparing = true,
      this.isDelivered = true,
      this.isStaff = true,
      this.walletDesc = 'Wallet balance',
      this.image = 'assets/icon/scan.png',
      this.price = '\$25',
      this.isShowScan = true})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: isShowScan ? 117 : 80,
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
                    Spacer(),
                    if (isEdit)
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(Routes.CAFETERIA);
                        },
                        child: Text(
                          "Edit",
                          style: AppTextStyles.MetropolisRegular.copyWith(
                            fontSize: 12,
                            color: const Color(0xFFFF9A0D),
                          ),
                        ),
                      ),
                    SizedBox(width: 8),
                    if (!isShowScan)
                      Image.asset(
                        'assets/icon/delete.png',
                        width: 15,
                        height: 15,
                      )
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
                if (isType)
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
                if (isDuration)
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
                if (isStaff)
                  Row(
                    children: [
                      Text(
                        "Staff Name: ",
                        style: AppTextStyles.MetropolisRegular.copyWith(
                            fontSize: 12, color: Colors.black),
                      ),
                      Text(
                        "Name",
                        style: AppTextStyles.MetropolisRegular.copyWith(
                            fontSize: 12, color: const Color(0xFF858585)),
                      ),
                    ],
                  ),
                if (isDeliveredBy)
                  Row(
                    children: [
                      Text(
                        "Delivered By: ",
                        style: AppTextStyles.MetropolisRegular.copyWith(
                            fontSize: 12, color: Colors.black),
                      ),
                      Text(
                        "Name",
                        style: AppTextStyles.MetropolisRegular.copyWith(
                            fontSize: 12, color: const Color(0xFF858585)),
                      ),
                    ],
                  ),
                SizedBox(height: 8),
                if (isPreparing)
                  Align(
                    alignment: Alignment.centerRight,
                    child: GradientButton(
                      height: 30,
                      width: 90,
                      onTap: () {
                        print("Preparing button tapped!");
                        // Add your onTap logic here
                      },
                    ),
                  ),
                if (isDelivered)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Delivered",
                      style: AppTextStyles.MetropolisMedium.copyWith(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Vertical Divider
          isShowScan
              ? Container(
                  width: 1,
                  color: Colors.black.withOpacity(0.1),
                  margin: const EdgeInsets.only(left: 6, right: 10),
                )
              : SizedBox.shrink(),

          // Wallet Balance Section
          isShowScan && !isNoImage
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
                  ],
                )
              : SizedBox.shrink(),

          isNoImage
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      price,
                      style: AppTextStyles.MetropolisMedium.copyWith(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                )
              : SizedBox.shrink()
        ],
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  final VoidCallback onTap; // Function to handle button tap
  final double height; // Height of the button
  final double width; // Width of the button

  const GradientButton({
    Key? key,
    required this.onTap,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), // Rounded corners
          gradient: const LinearGradient(
            colors: [Colors.red, Colors.orange], // Gradient colors
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.3), // Shadow color
              blurRadius: 8,
              offset: const Offset(0, 4), // Shadow position
            ),
          ],
        ),
        child: Center(
          child: Text(
            'Deliver',
            style: AppTextStyles.MetropolisMedium.copyWith(
              fontSize: 10,
              color: Colors.white, // Text color
            ),
          ),
        ),
      ),
    );
  }
}
