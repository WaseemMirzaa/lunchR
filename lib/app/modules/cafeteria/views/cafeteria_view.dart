import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luncher/app/routes/app_pages.dart';
import 'package:luncher/config/app_colors.dart';
import 'package:luncher/config/app_text_style.dart';
import 'package:luncher/widgets/custom_dialog_schedule.dart';

import 'package:luncher/widgets/custom_textfeild.dart';
import 'package:luncher/widgets/reuse_button.dart';

import '../controllers/cafeteria_controller.dart';

class CafeteriaView extends GetView<CafeteriaController> {
  const CafeteriaView({super.key});

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white

      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 42,
          bottom: 24,
          left: 4,
          right: 4,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        Get.back(); // Navigate back to the previous screen
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
                  SizedBox(
                    height: 8,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'SELECT CAFETERIA',
                      style: AppTextStyles.MetropolisMedium.copyWith(
                          color: Color(0xFF434343), fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 36,
                  ),
                  _buildSearchField(textController),
                  const SizedBox(height: 36),
                  _buildText(),
                  _buildCafeteriaList(context),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            // _buildBottomFixedButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCafeteriaList(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3, // 3 items in the list
      itemBuilder: (context, index) {
        return Obx(() => _buildCafeteriaItem(
            index, context)); // Wrap in Obx to listen for changes
      },
    );
  }

  Widget _buildCafeteriaItem(int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () async {
          // // Show the dialog and wait for the confirmation
          // bool isConfirmed = await showDialog<bool>(
          //       context: context,
          //       builder: (BuildContext context) {
          //         return ScheduleDialog(); // Your existing dialog
          //       },
          //     ) ??
          //     false;

          // // If user confirms, toggle selection of the item
          // if (isConfirmed) {

          // }
          Get.toNamed(Routes.MENU_PAGE);
        },
        child: Container(
          height: 127, // Adjusted height to fit all content comfortably
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: controller.selectedIndexes.contains(index)
                ? const Color(0xFFFC6011)
                    .withOpacity(0.2) // Background for selected item
                : Colors.white, // Default background
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 6,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image on the left
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/hotel.png', // Replace with actual image path
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),

              // Right section: Text Information and Divider
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cafeteria Name and Call Icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Cafeteria Name', // Replace with dynamic data
                            style: AppTextStyles.MetropolisMedium.copyWith(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            overflow:
                                TextOverflow.ellipsis, // Handle long names
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Call Icon
                        Image.asset(
                          'assets/icon/call.png', // Replace with actual call image path
                          width: 10,
                          height: 10,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Collage/School Name
                    Text(
                      'Collage / School Name', // Replace with dynamic data
                      style: AppTextStyles.MetropolisRegular.copyWith(
                        fontSize: 12,
                        color: const Color(0xFF858585),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Search TextField Widget (moved slightly down)
  Widget _buildSearchField(TextEditingController textController) {
    return TextFieldWidget(
      text: 'Search Cafeteria',
      textController: textController,
      path: 'assets/icon/search.png',
      isBGChangeColor: true,
      height: 40,
      isSuffixBG: true,
      onChanged: (value) {},
    );
  }

  // "Congratulations" text in the center
  Widget _buildText() {
    return Center(
      child: Text('Collage / School Name',
          style: AppTextStyles.PoppinsBold.copyWith(
            fontSize: 14,
            color: AppColors.blackColor,
          )),
    );
  }

  // // Bottom Fixed Button
  // Widget _buildBottomFixedButton() {
  //   return Align(
  //       alignment: Alignment.bottomCenter,
  //       child: CustomButton(
  //           height: 55,
  //           width: 325,
  //           text: 'CONFIRM',
  //           onPressed: () {
  //             Get.toNamed(Routes.MENU_PAGE);
  //           },
  //           isLoading: RxBool(false)));
  // }
}
