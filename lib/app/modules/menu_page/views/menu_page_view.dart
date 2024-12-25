import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luncher/app/routes/app_pages.dart';
import 'package:luncher/config/app_colors.dart';
import 'package:luncher/config/app_text_style.dart';

import 'package:luncher/widgets/reuse_button.dart';

import '../controllers/menu_page_controller.dart';

class MenuPageView extends GetView<MenuPageController> {
  const MenuPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white

      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 42),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
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
                              color: Colors
                                  .white, // Background color for the container
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
                      const SizedBox(
                        height: 8,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'SELECT MEAL',
                          style: AppTextStyles.MetropolisMedium.copyWith(
                              color: const Color(0xFF434343), fontSize: 18),
                        ),
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      _buildText(),
                      _buildMenuList(),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: _buildBottomFixedButton(),
            ),
          ],
        ),
      ),
    );
  }

  // "Congratulations" text in the center
  Widget _buildText() {
    return Center(
      child: Text(
        'Cafeteria Name',
        style: AppTextStyles.MetropolisBold.copyWith(
          fontSize: 14,
          color: AppColors.blackColor,
        ),
      ),
    );
  }

// List of Menu Items (GridView with Image, Name, Price)
  Widget _buildMenuList() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 items per row
        mainAxisSpacing: 16, // Spacing between rows
        crossAxisSpacing: 16, // Spacing between columns
        childAspectRatio: 100 / 156, // Aspect ratio for the containers
      ),
      itemCount: 6, // Total number of items
      itemBuilder: (context, index) {
        return _buildMenuItem();
      },
    );
  }

  Widget _buildMenuItem() {
    return SizedBox(
      width: 153,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Placeholder
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/gravy.png', // Replace with actual image path
              width: double.infinity, // Image takes the full width
              height: 91, // Full height of the container
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 6), // Spacing between image and text

          // Menu Item Name and Price
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Menu Item Name
              Text(
                'Item Name', // Replace with dynamic name
                style: AppTextStyles.MetropolisMedium.copyWith(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
              // Menu Item Price
              const SizedBox(
                height: 4,
              ),
              Text(
                '\$9.99', // Replace with dynamic price
                style: AppTextStyles.MetropolisMedium.copyWith(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6), // Spacing between price and "Add" button

          // Add Button at the Bottom Right
          Row(
            mainAxisAlignment:
                MainAxisAlignment.end, // Align the "Add" button to the right
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 6,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Text(
                  'Add', // Static "Add" text
                  style: AppTextStyles.PoppinsRegular.copyWith(
                    fontSize: 7,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Bottom Fixed Button
  Widget _buildBottomFixedButton() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: CustomButton(
            height: 55,
            width: double.infinity,
            text: 'CONFIRM',
            onPressed: () {
              Get.back();
            },
            isLoading: RxBool(false)));
  }
}
