import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:luncher/app/routes/app_pages.dart';
import 'package:luncher/config/app_text_style.dart';
import 'package:luncher/widgets/custom_textfeild.dart';
import 'package:luncher/widgets/reuse_button.dart';

import '../controllers/cafeteria_detail_controller.dart';

class CafeteriaDetailView extends GetView<CafeteriaDetailController> {
  const CafeteriaDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    final TextEditingController mealController = TextEditingController();
    final TextEditingController priceController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
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
                  height: 50,
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
                        'Upload Cafeteria Photo',
                        style: AppTextStyles.MetropolisRegular.copyWith(
                            fontSize: 12, color: const Color(0xFFB6B7B7)),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldWidget(
                    isSuffix: true,
                    text: 'Cafeteria Name',
                    textController: mealController),
                const SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                    isSuffix: true,
                    text: 'School / Collage Name',
                    textController: priceController),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: CustomButton(
                text: 'CONTINUE',
                onPressed: () {
                  Get.toNamed(Routes.CAFETERIA_MEAL_DETAILS);
                },
                isLoading: RxBool(false)),
          )
        ],
      ),
    );
  }
}
