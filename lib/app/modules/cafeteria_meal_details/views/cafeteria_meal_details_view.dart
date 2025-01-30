import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:luncher/app/routes/app_pages.dart';
import 'package:luncher/config/app_text_style.dart';

import 'package:luncher/widgets/custom_textfeild.dart';
import 'package:luncher/widgets/custom_textfield_without_suffix.dart';
import 'package:luncher/widgets/reuse_button.dart';

import '../controllers/cafeteria_meal_details_controller.dart';

class CafeteriaMealDetailsView extends GetView<CafeteriaMealDetailsController> {
  const CafeteriaMealDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController mealController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                const SizedBox(
                  height: 40,
                ),
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
                        color:
                            Colors.white, // Background color for the container
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
                  height: 20,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'MEAL DETAILS',
                    style: AppTextStyles.MetropolisMedium.copyWith(
                        color: const Color(0xFF434343), fontSize: 18),
                  ),
                ),
                const SizedBox(
                  height: 36,
                ),
                const SimpleTextFieldWithOutSuffixWidget(hintText: 'Meal Name'),
                const SizedBox(
                  height: 16,
                ),
                const SimpleTextFieldWithOutSuffixWidget(
                    hintText: 'Availability'),
                const SizedBox(
                  height: 16,
                ),
                const SimpleTextFieldWithOutSuffixWidget(hintText: 'Price'),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  width: double.infinity,
                  height: 127, // Fixed height
                  decoration: BoxDecoration(
                    color: Colors.white, // Set background color
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3), // Shadow color
                        spreadRadius: 2, // Spread of the shadow
                        blurRadius: 6, // Blur intensity of the shadow
                        offset:
                            const Offset(0, 3), // Offset of the shadow (X, Y)
                      ),
                    ],
                    borderRadius:
                        BorderRadius.circular(20), // Optional: round corners
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/icon/camera.png',
                          width: 60,
                          height: 50,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Upload Meal Photo',
                        style: AppTextStyles.MetropolisRegular.copyWith(
                            fontSize: 12, color: const Color(0xFFB6B7B7)),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          CustomButton(
              text: 'SUBMIT',
              onPressed: () {
                Get.offAllNamed(Routes.CAFETERIA_LANDING_PAGE);
              },
              isLoading: RxBool(false))
        ],
      ),
    );
  }
}
