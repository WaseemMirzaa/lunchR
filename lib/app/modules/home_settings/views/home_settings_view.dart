import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:luncher/app/modules/cafeteria_settings/views/cafeteria_setting_widget.dart';
import 'package:luncher/app/modules/parents_history_list/views/parents_history_list_view.dart';
import 'package:luncher/app/modules/profile/views/profile_view.dart';
import 'package:luncher/app/modules/settings/views/settings_view.dart';
import 'package:luncher/config/app_text_style.dart';

import '../controllers/home_settings_controller.dart';

class HomeSettingsView extends GetView<HomeSettingsController> {
  const HomeSettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GetBuilder<HomeSettingsController>(
            init: HomeSettingsController(),
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 70,
                  ),

                  // Settings Title
                  Text(
                    'SETTINGS', // Title text
                    style: AppTextStyles.MetropolisMedium.copyWith(
                      fontSize: 18,
                      color: const Color(0xFF434343),
                    ),
                  ),
                  // const SizedBox(height: 56), // Spacing between title and list

                  // define the row of setting page
                  const SizedBox(height: 40), // Spacing between title and list
                  CafeteriaSettingWidget(
                    labelName: "Profile",
                    onTap: () {
                      // Get.toNamed(Routes.PROFILE);
                    },
                  ),
                  CafeteriaSettingWidget(
                    labelName: "History",
                    onTap: () {
                      // Get.toNamed(Routes.CAFETERIA_ADD_STAFF, arguments: true);
                      // Get.toNamed(Routes.CAFETERIA_STAFF_LIST);
                    },
                  ),
                  // CafeteriaSettingWidget(
                  //   labelName: "Privacy Policy",
                  //   onTap: () {
                  //     print("object Pressed");
                  //   },
                  // ),
                  CafeteriaSettingWidget(
                    labelName: "Privacy Policy",
                    onTap: () {
                      print("object Pressed");
                    },
                  ),
                  CafeteriaSettingWidget(
                    labelName: "Terms & Conditions",
                    onTap: () {
                      print("object Pressed");
                    },
                  ),
                  CafeteriaSettingWidget(
                    labelName: "Sign Out",
                    onTap: () {
                      controller.logout();
                      // Get.offAllNamed(Routes.SPLASH);
                      // print("object Pressed");
                    },
                  ),
                ],
              );
            }
        ),
      )
      // Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      //   Expanded(
      //     child: Obx(
      //       () => IndexedStack(
      //         index: controller
      //             .selectedIndex.value, // Bind the selected index to controller
      //         children: const [
      //           // First child
      //           SettingsView(),
      //
      //           // Third child
      //           ProfileView(),
      //
      //           ParentsHistoryListView(),
      //         ],
      //       ),
      //     ),
      //   ),
      // ]),
    );
  }
}
