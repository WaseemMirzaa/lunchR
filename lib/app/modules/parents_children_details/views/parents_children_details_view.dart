import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luncher/app/routes/app_pages.dart';
import 'package:luncher/config/app_colors.dart';
import 'package:luncher/config/app_text_style.dart';
import 'package:luncher/widgets/custom_dialog.dart';
import 'package:luncher/widgets/custom_selectable_options.dart';
import 'package:luncher/widgets/custom_textfield_without_suffix.dart';
import 'package:luncher/widgets/reuse_button.dart';

import '../controllers/parents_children_details_controller.dart';

class ParentsChildrenDetailsView extends GetView<ParentsChildrenDetailsController> {
  final bool isAddedMenuItems;

  const ParentsChildrenDetailsView({
    super.key,
    this.isAddedMenuItems = false, // Optional parameter with default value
  });

  @override
  Widget build(BuildContext context) {
    // Override the default value with the argument if provided
    // final bool isMenuItemsAdded = Get.arguments?['isAddedMenuItems'] ?? isAddedMenuItems;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Obx(() {
          final int numberOfChildren = controller.numberOfChildren.value;
          final bool allInSameSchool = controller.selectedClassRoomDeliveryOption.value == 'Yes';

          // if (numberOfChildren == 0) {
          //   // If no children are selected, show only the Continue button
          //   return Center(
          //     child: Column(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.symmetric(horizontal: 20),
          //           child: Column(
          //             children: [
          //               const SizedBox(height: 90),
          //               Align(
          //                 alignment: Alignment.center,
          //                 child: Text(
          //                   'CHILDREN DETAILS',
          //                   style: AppTextStyles.MetropolisMedium.copyWith(
          //                     color: const Color(0xFF434343),
          //                     fontSize: 18,
          //                   ),
          //                 ),
          //               ),
          //               const SizedBox(height: 40),
          //               _buildTextFieldWithChildrenCounter(
          //                 numberOfChildren: numberOfChildren,
          //                 onDecrement: controller.decrementChildren,
          //                 onIncrement: controller.incrementChildren,
          //               ),
          //             ],
          //           ),
          //         ),
          //         // const SizedBox(height: 32),
          //         // Padding(
          //         //   padding: const EdgeInsets.symmetric(horizontal: 15),
          //         //   child: CustomButton(
          //         //     fontSize: 16,
          //         //     isBackColor: true,
          //         //     text: 'CONTINUE',
          //         //     onPressed: () {
          //         //       Get.offAllNamed(Routes.LANDING_PAGE);
          //         //     },
          //         //     isLoading: RxBool(false),
          //         //   ),
          //         // ),
          //         const SizedBox(height: 32),
          //       ],
          //     ),
          //   );
          // } else {
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
                      child: _buildClassRoomDelivery(),
                    ),
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
                            _buildCenterImage(index), // Center Image
                            const SizedBox(height: 16),
                            _buildTextFields(context, index, allInSameSchool),

                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                    // Show "Add Menu Items" button conditionally
                    // if (allInSameSchool && !isMenuItemsAdded) const SizedBox(height: 12),
                    // if (allInSameSchool && !isMenuItemsAdded)
                    if (allInSameSchool) const SizedBox(height: 12),
                    if (allInSameSchool)
                      CustomButton(
                        text: 'ADD MENU ITEMS',
                        onPressed: () {},
                        isLoading: false.obs,
                      ),

                    // Add the "School/College Name" text field conditionally
                    if (!allInSameSchool)
                      Column(
                        children: [
                          const SizedBox(height: 12),
                          if (allInSameSchool) _buildSchoolTextField(context),
                          const SizedBox(height: 12),
                          // if (!isMenuItemsAdded)
                          CustomButton(
                            text: 'ADD MENU ITEMS',
                            onPressed: () {
                              print(
                                  "same school ${allInSameSchool} and  menu item added is ${"isMenuItemsAdded"}");
                            },
                            isLoading: false.obs,
                          ),
                        ],
                      ),
                    if (allInSameSchool) ...[
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Divider(color: Color(0xFFE9E9E9), thickness: 1),
                      ),
                      const SizedBox(height: 20),
                      _buildSchoolTextField(context), // Single School/College Name field
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
                  controller.printChildrenData();
                  // Get.offAllNamed(Routes.LANDING_PAGE);
                },
                isLoading: RxBool(false),
              ),
              const SizedBox(height: 32),
            ],
          );
          // }
        }),
      ),
    );
  }

  // Type of Payment
  Widget _buildClassRoomDelivery() {
    return SelectableOptions(
      title: 'All Children are in same School?',
      options: const ['No', 'Yes'],
      selectedOption:
          controller.selectedClassRoomDeliveryOption, // Pass the observable to SelectableOptions
      isRowLayout: true,
    );
  }

  // Center circular image
  Widget _buildCenterImage(int index) {
    print("index image is $index");
    return Center(
      child: GestureDetector(
        onTap: () {
          controller.pickImage(index);
        },
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
                color: Colors.black.withOpacity(0.25), // Shadow color with transparency
                blurRadius: 8, // Spread of the shadow
                offset: const Offset(0, 4), // Position of the shadow (x, y)
              ),
            ],
          ),
          child: ClipOval(
            // Ensures the image stays within the circular shape
            child: (controller.images.isNotEmpty &&
                controller.images[index] != null &&
                controller.images[index]!.existsSync())
                ? Image.file(
              controller.images[index]!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset("assets/icon/camera.png", fit: BoxFit.contain),
                );
              },
            )
                : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset("assets/icon/camera.png", fit: BoxFit.contain),
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
              borderRadius: BorderRadius.circular(20), // Set border radius to 20

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
// Modify the _buildTextFields() method in ParentsChildrenDetailsView
  Widget _buildTextFields(BuildContext context, int index, bool allInSameSchool) {
    // Check if controllers exist for this index
    if (index >= controller.nameControllers.length || index >= controller.idControllers.length) {
      return const SizedBox(); // Return empty widget if controllers don't exist
    }

    return Column(
      children: [
        SimpleTextFieldWithOutSuffixWidget(
          hintText: 'Child Name',
          controller: controller.nameControllers[index],
        ),
        const SizedBox(height: 12),
        SimpleTextFieldWithOutSuffixWidget(
          hintText: 'Child School ID',
          controller: controller.idControllers[index],
        ),
        const SizedBox(height: 12),
        if (!allInSameSchool)
          SimpleTextFieldWithOutSuffixWidget(
            hintText: 'School/Collage Name',
            isReadOnly: true,
            controller: controller
                .schoolNameControllerList[index], // Add this controller to your main controller
            onTap: () async {
              // controller.fetchSchoolNames();
              print("Fetched School Names: ${controller.schoolNamesList}");

              final selectedSchool =
                  await SchoolSelectorDialog.show(context, controller.schoolNamesList);
              print("Selected School Names: $selectedSchool");
              if (selectedSchool != null) {
                controller.schoolNameControllerList[index].text =
                    selectedSchool; // ✅ Correct way to assign value
                print(
                    "Selected School Name for Child $index: ${controller.schoolNameControllerList[index].text}");
              }

              // if (selectedSchool != null) {
              //   controller.schoolNameController.text = selectedSchool;
              //   // Navigate to next screen if needed
              //   Get.toNamed(Routes.CHILDREN_DETAILS);
              // }
            },
          ),
      ],
    );
  }

  Widget _buildSchoolTextField(BuildContext context) {
    return Column(
      children: [
        SimpleTextFieldWithOutSuffixWidget(
          hintText: 'School/Collage Name',
          isReadOnly: true,
          controller:
              controller.schoolNameController, // Add this controller to your main controller
          onTap: () async {
            // controller.fetchSchoolNames();
            print("Fetched School Names: ${controller.schoolNamesList}");

            final selectedSchool =
                await SchoolSelectorDialog.show(context, controller.schoolNamesList);
            print("Selected School Names: $selectedSchool");

            // if (selectedSchool != null) {
            //   controller.schoolNameController.text = selectedSchool;
            //   // Navigate to next screen if needed
            //   Get.toNamed(Routes.CHILDREN_DETAILS);
            // }
          },
        ),
      ],
    );
  }
}
