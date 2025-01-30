import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luncher/app/routes/app_pages.dart';
import 'package:luncher/config/app_colors.dart';
import 'package:luncher/config/app_text_style.dart';
import 'package:luncher/widgets/custom_selectable_options.dart';

import 'package:luncher/widgets/reuse_button.dart';
import '../controllers/children_details_controller.dart';

class ChildrenDetailsView extends GetView<ChildrenDetailsController> {
  const ChildrenDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white

      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 42, bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
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
                      'CAFETERIA DETAILS',
                      style: AppTextStyles.MetropolisMedium.copyWith(
                          color: const Color(0xFF434343), fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSelectCafeteria(),
                        const SizedBox(height: 16),
                        _buildCafeteriaDetails(),
                        const SizedBox(height: 12),
                        _buildSelectMeal(),
                        const SizedBox(height: 16),
                        _selectMealDeals(),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment
                              .centerRight, // Aligns content to the right
                          child: GestureDetector(
                            onTap: () {
                              // Add your logic here
                              Get.toNamed(Routes.MENU_PAGE);
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize
                                  .min, // Ensures the row only takes as much space as needed
                              children: [
                                Image.asset(
                                  "assets/icon/add.png",
                                  height: 15, // Set the height to 15
                                  width: 15, // Set the width to 15
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "Add",
                                  style: AppTextStyles.PoppinsRegular.copyWith(
                                    fontSize: 13,
                                    color: const Color(0xFFF4C150),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        _buildClassRoomDelivery(),
                        const SizedBox(height: 34),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            CustomButton(
                fontSize: 16,
                isBackColor: true,
                text: 'SUBMIT',
                onPressed: () {
                  Get.offAllNamed(
                    Routes.PARENTS_CHILDREN_DETAILS,
                    arguments: {
                      'isAddedMenuItems': true, // Pass the parameter here
                    },
                  );
                },
                isLoading: RxBool(false)),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

// Type of Payment

  // Type of Payment
  Widget _buildClassRoomDelivery() {
    return SelectableOptions(
      isSingleRow: true,
      title: 'Classroom Delivery?',
      options: const ['No', 'Yes'],
      selectedOption: controller
          .selectedClassRoomDeliveryOption, // Pass the observable to SelectableOptions
      isRowLayout: true,
    );
  }

  // Duration
  Widget _buildDuration() {
    return SelectableOptions(
      title: 'Duration',
      options: const ['Weekly', 'Monthly'],
      selectedOption: controller
          .selectedDurationOption, // Reuse the same observable if needed
    );
  }

  // Select Cafeteria Row
  Widget _buildSelectCafeteria() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Select Cafeteria",
          style: AppTextStyles.MetropolisMedium.copyWith(
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Widget _buildTimeWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 56),
          child: Text(
            "2:00 PM",
            style: AppTextStyles.MetropolisRegular.copyWith(
              fontSize: 12,
            ),
          ),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () async {
                await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                  builder: (BuildContext context, Widget? child) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                        primaryColor: const Color(
                            0xFFE65100), // Dark orange for primary color
                        buttonTheme: const ButtonThemeData(
                          textTheme:
                              ButtonTextTheme.primary, // Button text color
                        ),
                        // Customizing time picker button colors
                        timePickerTheme: const TimePickerThemeData(
                          backgroundColor:
                              Color(0xFFFFE0B2), // Light orange background
                          dialBackgroundColor:
                              Color(0xFFFF7043), // Dark orange dial background
                          dialHandColor:
                              Color(0xFFE65100), // Dark orange dial hand
                          dialTextColor: Color.fromARGB(
                              255, 255, 255, 255), // Lighter orange dial text
                          entryModeIconColor:
                              Color(0xFFE65100), // Dark orange entry mode icon
                        ),
                        cardColor: const Color(
                            0xFFFFA726), // Light orange for selection card background
                        dialogBackgroundColor:
                            const Color(0xFFFFE0B2), // Light orange for dialogs
                        textTheme: const TextTheme(
                          bodyLarge: TextStyle(
                              color: Color(0xFFE65100)), // Dark orange text
                          bodyMedium: TextStyle(
                              color: Color(0xFFFF7043)), // Darker orange text
                        ),
                        colorScheme: const ColorScheme.light(
                          primary: Color(0xFFE65100), // Dark orange primary
                          onPrimary: Color(
                              0xFFFFE0B2), // Light orange for text on primary
                          secondary:
                              Color(0xFFFF7043), // Secondary as darker orange
                          onSecondary: Color(0xFFFFE0B2), // Text on secondary
                          background:
                              Color(0xFFFFCC80), // Light orange background
                          onBackground: Color(0xFFE65100), // Text on background
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
              },
              child: Row(
                children: [
                  Image.asset(
                    "assets/icon/add.png",
                    height: 15, // Set the height to 15
                    width: 15, // Set the width to 15
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Time', // Display selected time
                    style: AppTextStyles.MetropolisRegular.copyWith(
                      fontSize: 13,
                      color: const Color(0xFFF4C150),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildAddAmount() {
    return Text(
      "Add Wallet Amount",
      style: AppTextStyles.PoppinsMedium.copyWith(
        fontSize: 15,
      ),
    );
  }

  Widget _buildTimeofMeal() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Time of the meal",
          style: AppTextStyles.MetropolisMedium.copyWith(
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Widget _buildSelectMeal() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Selected Order",
          style: AppTextStyles.PoppinsMedium.copyWith(
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  // Cafeteria details container
  Widget _buildCafeteriaDetails() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ],
        ),
        height: 62, // Set the height to 62
        child: Row(
          children: [
            Container(
              width: 43, // Set the width to 43
              height: 43, // Set the height to 43
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.grey[300],
                image: const DecorationImage(
                  image: AssetImage(
                    'assets/images/restr.png', // Replace with your image
                  ),
                  fit: BoxFit
                      .cover, // Ensure the image fits inside the container
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Expanded Row for Cafeteria Name + Call icon and College Name
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Cafeteria Name",
                        style: AppTextStyles.MetropolisMedium.copyWith(
                          fontSize: 11,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(), // This pushes the call icon to the rightmost side
                      Image.asset(
                        "assets/icon/call.png",
                        height: 10, // Set the height to 10
                        width: 10, // Set the width to 10
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "College / School Name",
                    style: AppTextStyles.MetropolisRegular.copyWith(
                      fontSize: 9,
                      color: const Color(0xFF858585),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _selectMealDeals() {
    return Container(
      height: 100,
      padding:
          const EdgeInsets.all(8), // Optional: for padding inside the container
      decoration: BoxDecoration(
        color: Colors.white, // Background color of the container
        borderRadius:
            BorderRadius.circular(12), // Rounded corners for the container
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // Shadow color with opacity
            blurRadius: 6, // Blur effect for the shadow
            spreadRadius: 2, // Spread of the shadow
            offset: const Offset(0, 2), // Shadow offset (vertical)
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Container(
              width: 70,
              height: 81,
              decoration: BoxDecoration(
                color: Colors.grey[300], // Placeholder for image or content
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage(
                      'assets/images/gravy.png'), // Replace with your image
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          // "Chicken Gravy" text with ellipsis to prevent wrapping
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Text(
                  "Chicken Gravy",
                  maxLines: 1, // Ensure text stays in one line
                  overflow:
                      TextOverflow.ellipsis, // Prevents text from wrapping
                  style: AppTextStyles.MetropolisMedium.copyWith(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              // "$35" text with ellipsis as well
              Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Text(
                  "\$35",
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.MetropolisMedium.copyWith(
                    fontSize: 11,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              // product description
              // Obx(() {
              //   final selectedTimes = controller.scheduleController.selectedTimes
              //       .asMap()
              //       .entries
              //       .where((entry) => entry.value)
              //       .map((entry) => controller.scheduleController.availableTimes[entry.key]) // Map the index to the actual time value
              //       .join(', ');
              //
              //
              //   final selectedDays = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
              //       .asMap()
              //       .entries
              //       .where((entry) => controller.scheduleController.selectedDays[entry.key]) // Only take the selected (true) days
              //       .map((entry) => entry.value)
              //       .join(', ');
              //
              //   if (selectedTimes.isEmpty || selectedDays.isEmpty) {
              //     return const SizedBox.shrink();
              //   }
              //
              //   return Text(
              //     'Your order is scheduled for $selectedTimes to repeat on $selectedDays every ${controller.scheduleController.repeatUnit.value}',
              //     style: AppTextStyles.MetropolisRegular.copyWith(fontSize: 12),
              //   );
              // }),

              Text('Your order is scheduled at 12am \nevery week.', style: AppTextStyles.PoppinsMedium.copyWith(
                fontSize: 11,
                color: Colors.black,
              ),)
            ],
          )
        ],
      ),
    );
  }

  // Generic method for selectable options
  Widget _buildAddWalletAmount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left side: Add Amount Button inside its own container
        Container(
          width: 173,
          height: 53,
          child: CustomButton(
            isBackColor: false,
            width: double.infinity,
            height: double.infinity,
            text: 'Add Amount',
            isForcedTextColor: true,
            fontSize: 13,
            onPressed: () {},
            isLoading: RxBool(false),
          ),
        ),

        // Right side: Wallet Balance Text inside its own container
        Container(
          padding:
              const EdgeInsets.only(right: 16), // Optional padding for spacing
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "\$25",
                style: AppTextStyles.PoppinsMedium.copyWith(
                  fontSize: 27,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Wallet Balance",
                style: AppTextStyles.PoppinsMedium.copyWith(
                  fontSize: 11,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
