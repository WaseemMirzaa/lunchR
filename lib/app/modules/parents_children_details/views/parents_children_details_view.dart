import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:luncher/app/routes/app_pages.dart';
import 'package:luncher/config/app_colors.dart';
import 'package:luncher/config/app_text_style.dart';
import 'package:luncher/widgets/custom_clickable_container.dart';
import 'package:luncher/widgets/custom_dialog.dart';
import 'package:luncher/widgets/custom_selectable_options.dart';
import 'package:luncher/widgets/custom_textfeild.dart';
import 'package:luncher/widgets/custom_textfield_without_suffix.dart';
import 'package:luncher/widgets/reuse_button.dart';

import '../controllers/parents_children_details_controller.dart';

class ParentsChildrenDetailsView
    extends GetView<ParentsChildrenDetailsController> {
  const ParentsChildrenDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Obx(() {
          final int numberOfChildren = controller.numberOfChildren.value;
          final bool allInSameSchool =
              controller.selectedClassRoomDeliveryOption.value == 'Yes';

          if (numberOfChildren == 0) {
            // If no children are selected, show only the Continue button
            return Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 90),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'CHILDREN DETAILS',
                            style: AppTextStyles.MetropolisMedium.copyWith(
                              color: const Color(0xFF434343),
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        _buildTextFieldWithChildrenCounter(
                          numberOfChildren: numberOfChildren,
                          onDecrement: controller.decrementChildren,
                          onIncrement: controller.incrementChildren,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: CustomButton(
                      fontSize: 16,
                      isBackColor: true,
                      text: 'CONTINUE',
                      onPressed: () {
                        Get.toNamed(Routes.CHILDREN_DETAILS);
                      },
                      isLoading: RxBool(false),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            );
          } else {
            // If children are selected, show all widgets
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 90),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'CHILDREN DETAILS',
                          style: AppTextStyles.MetropolisMedium.copyWith(
                            color: const Color(0xFF434343),
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      _buildTextFieldWithChildrenCounter(
                        numberOfChildren: numberOfChildren,
                        onDecrement: controller.decrementChildren,
                        onIncrement: controller.incrementChildren,
                      ),
                      const SizedBox(height: 24),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: _buildClassRoomDelivery()),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Divider(color: Color(0xFFE9E9E9), thickness: 1),
                      ),
                      const SizedBox(height: 4),
                      Column(
                        children: List.generate(
                          numberOfChildren,
                          (index) => Column(
                            children: [
                              _buildCenterImage(), // Center Image
                              const SizedBox(height: 16),
                              _buildTextFields(), // Text fields for child's name and ID

                              // Add the "School/College Name" text field conditionally
                              if (!allInSameSchool)
                                Column(
                                  children: [
                                    const SizedBox(height: 12),
                                    _buildSchoolTextField(context),
                                  ],
                                ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                      if (allInSameSchool) ...[
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child:
                              Divider(color: Color(0xFFE9E9E9), thickness: 1),
                        ),
                        const SizedBox(height: 20),
                        _buildSchoolTextField(
                            context), // Single School/College Name field
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                CustomButton(
                  fontSize: 16,
                  isBackColor: true,
                  text: 'CONTINUE',
                  onPressed: () {
                    Get.toNamed(Routes.CHILDREN_DETAILS);
                  },
                  isLoading: RxBool(false),
                ),
                const SizedBox(height: 32),
              ],
            );
          }
        }),
      ),
    );
  }

  // Type of Payment
  Widget _buildClassRoomDelivery() {
    return SelectableOptions(
      title: 'All Children are in same School?',
      options: const ['No', 'Yes'],
      selectedOption: controller
          .selectedClassRoomDeliveryOption, // Pass the observable to SelectableOptions
      isRowLayout: true,
    );
  }

  // Center circular image
  Widget _buildCenterImage() {
    return Center(
      child: Container(
        width: 53,
        height: 53,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(
            color: Colors.white, // White border color
            width: 3, // Border width
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(0.25), // Shadow color with transparency
              blurRadius: 8, // Spread of the shadow
              offset: const Offset(0, 4), // Position of the shadow (x, y)
            ),
          ],
        ),
        child: ClipOval(
          // Ensures the image stays within the circular shape
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(
              "assets/icon/camera.png",
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

  // Method returning a Widget
  Widget _buildTextFieldWithChildrenCounter({
    required int numberOfChildren,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Container(
      height: 56,
      padding: const EdgeInsets.only(left: 30, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Prefix text
          Expanded(
            child: Text(
              'No. of Children',
              style: AppTextStyles.MetropolisMedium.copyWith(
                fontSize: 16, // Set desired font size
                color: const Color(0xFF4A4B4D), // Text color
              ),
            ),
          ),

          // Suffix with +, number, and -
          Container(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius:
                  BorderRadius.circular(20), // Set border radius to 20

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  // Decrement button (-)
                  GestureDetector(
                    onTap: onDecrement,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          '-',
                          style: AppTextStyles.PoppinsRegular.copyWith(
                            fontSize: 13,
                            color: const Color(0xFF1D1D1D),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Number of Children
                  Text(
                    '$numberOfChildren',
                    style: AppTextStyles.PoppinsRegular.copyWith(
                      fontSize: 13,
                      color: const Color(0xFF1D1D1D),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Increment button (+)
                  GestureDetector(
                    onTap: onIncrement,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          '+',
                          style: AppTextStyles.PoppinsRegular.copyWith(
                            fontSize: 13,
                            color: const Color(0xFF1D1D1D),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Reusable text fields
  Widget _buildTextFields() {
    return const Column(
      children: [
        SimpleTextFieldWithOutSuffixWidget(hintText: 'Child Name'),
        SizedBox(height: 12),
        SimpleTextFieldWithOutSuffixWidget(hintText: 'Child School ID'),
      ],
    );
  }

  Widget _buildSchoolTextField(BuildContext context) {
    return Column(
      children: [
        SimpleTextFieldWithOutSuffixWidget(
          hintText: 'School/Collage Name',
          isReadOnly: true,
          onTap: () async {
            print('School/Collage Name');
            await SchoolSelectorDialog.show(context);
          },
        ),
      ],
    );
  }
}
