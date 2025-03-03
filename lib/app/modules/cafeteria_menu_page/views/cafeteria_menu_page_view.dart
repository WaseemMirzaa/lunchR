import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';

import 'package:get/get.dart';
import 'package:luncher/app/routes/app_pages.dart';
import 'package:luncher/config/app_colors.dart';
import 'package:luncher/config/app_text_style.dart';
import 'package:luncher/models/cefeteria_admin/meal_model.dart';
import 'package:luncher/widgets/Custom_search_textfield.dart';
import 'package:luncher/widgets/custom_textfeild.dart';

import 'package:luncher/widgets/reuse_button.dart';

import '../controllers/cafeteria_menu_page_controller.dart';

class CafeteriaMenuPageView extends GetView<CafeteriaMenuPageController> {
  const CafeteriaMenuPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white

      body: GestureDetector(
        onTap:(){
          FocusScope.of(context).unfocus();
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          // color: Colors.red,
          child: Stack(
            children: [
              ListView(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 70,
                        ),

                        // Settings Title
                        Text(
                          'SELECT MEAL', // Title text
                          style: AppTextStyles.MetropolisMedium.copyWith(
                            fontSize: 18,
                            color: const Color(0xFF434343),
                          ),
                        ),
                        const SizedBox(height: 42), // Spacing between title and list
                        _buildSearchField(controller.searchTextController),
                        const SizedBox(height: 30),
                        _buildText(),
                        const SizedBox(height: 32),

                        _buildMenuList(),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                  // _buildBottomFixedButton(),
                ],
              ),
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: _buildBottomFixedButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Search TextField Widget (moved slightly down)
  Widget _buildSearchField(TextEditingController textController) {
    // return TextFieldWidget(
    //   text: 'Search Meal',
    //   textController: textController,
    //   path: 'assets/icon/search.png',
    //   isBGChangeColor: true,
    //   height: 40,
    //   isSuffixBG: true,
    //   onChanged: (value) => controller.updateSearchText(value),
    // );
      return SearchTextFieldWidget(
      hintText: 'Search Meal',
      textController: textController,
      onChanged: (value) => controller.updateSearchText(value),
    );
  }

  // "Congratulations" text in the center
  Widget _buildText() {
    return Center(
      child: Text(
        'Collage/School Name', // Replace with dynamic text
        style: AppTextStyles.PoppinsBold.copyWith(
          fontSize: 14,
          color: AppColors.blackColor,
        ),
      ),
    );
  }

  Widget _buildMenuList() {
    return Obx(() => controller.isLoading.value
        ? const Center(child: CircularProgressIndicator())
        :controller.isdataFound.value == true?Text(
      'Data Not Found', // Replace with dynamic text
      style: AppTextStyles.PoppinsBold.copyWith(
        fontSize: 14,
        color: AppColors.blackColor,
      ),
    ):controller.meals.value.isEmpty?Text(
      'Meal Not Available', // Replace with dynamic text
      style: AppTextStyles.PoppinsBold.copyWith(
        fontSize: 14,
        color: AppColors.blackColor,
      ),
    ):
    // GridView.builder(
    //             shrinkWrap: true,
    //             physics: const NeverScrollableScrollPhysics(),
    //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //               crossAxisCount: 3,
    //               mainAxisSpacing: 16,
    //               crossAxisSpacing: 8,
    //               childAspectRatio: 100 / 170,
    //             ),
    //             itemCount: controller.searchText.value.isEmpty
    //                 ? controller.meals.length
    //                 : controller.filteredMeals.length,
    //             itemBuilder: (context, index) {
    //               return _buildMenuItem(
    //                 controller.searchText.value.isEmpty
    //                     ? controller.meals[index]
    //                     : controller.filteredMeals[index],
    //               );
    //             },
    //           )
    GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 16,
        crossAxisSpacing: 8,
        childAspectRatio: 100 / 170,
      ),
      itemCount: controller.filteredMeals.length,
      itemBuilder: (context, index) {
        return _buildMenuItem(
        controller.filteredMeals[index]
        );
      },
    )
    );
  }

  Widget _buildMenuItem(
    MealModel meal,
  ) {
    final _controller = ValueNotifier<bool>(meal.availability == 'available');

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image from Firestore
            meal.imageUrl != null && meal.imageUrl!.isNotEmpty
                ? Image.network(
                    meal.imageUrl!,
                    width: double.infinity,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/gravy.png',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      );
                    },
                  )
                : Image.asset(
                    'assets/images/gravy.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          meal.name ?? 'Unnamed Item',
                          style: AppTextStyles.MetropolisMedium.copyWith(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (meal.id != null) {
                            controller.deleteMeal(meal.id!);
                          }
                        },
                        child: Image.asset(
                          'assets/icon/delete.png',
                          width: 15,
                          height: 15,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${meal.price ?? "0"}',
                    style: AppTextStyles.MetropolisMedium.copyWith(
                      fontSize: 10,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AdvancedSwitch(
                    controller: _controller,
                    activeColor: Colors.green,
                    height: 12,
                    width: 25,
                    onChanged: (value) {
                      if (meal.id != null) {
                        controller.updateMeal(
                            meal.id!, {'availability': value ? 'available' : 'unavailable'});
                      }
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        Routes.CAFETERIA_MEAL_DETAILS,
                        arguments: meal, // Pass MealModel as argument
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: const Color(0xFFEFEFEF),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF707070).withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(0, 1),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(32),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      child: Text(
                        'Edit',
                        style: AppTextStyles.PoppinsRegular.copyWith(
                          fontSize: 7,
                          color: const Color(0xFFFFAA00),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
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
            text: 'Add',
            onPressed: () {
              Get.toNamed(Routes.CAFETERIA_MEAL_DETAILS);
            },
            isLoading: RxBool(false)));
  }
}
