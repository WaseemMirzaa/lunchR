import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:luncher/app/modules/cafeteria_add_staff/controllers/cafeteria_add_staff_controller.dart';
import 'package:luncher/app/modules/cafeteria_add_staff/views/cafeteria_add_staff_view.dart';
import 'package:luncher/app/modules/cafeteria_history_list/views/cafeteria_history_list_view.dart';
import 'package:luncher/app/modules/cafeteria_settings/controllers/cafeteria_settings_controller.dart';
import 'package:luncher/app/modules/cafeteria_settings/views/cafeteria_setting_widget.dart';
import 'package:luncher/app/modules/cafeteria_settings/views/cafeteria_settings_view.dart';
import 'package:luncher/app/modules/cafeteria_staff_list/views/cafeteria_staff_list_view.dart';
import 'package:luncher/app/modules/profile/views/profile_view.dart';
import 'package:luncher/app/routes/app_pages.dart';
import 'package:luncher/config/app_text_style.dart';

import '../controllers/cafeteria_home_settings_controller.dart';

class CafeteriaHomeSettingsView extends GetView<CafeteriaSettingsController> {
  const CafeteriaHomeSettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GetBuilder<CafeteriaSettingsController>(
            init: CafeteriaSettingsController(),
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
                      Get.toNamed(Routes.PROFILE);
                    },
                  ),
                  CafeteriaSettingWidget(
                    labelName: "Add Staff members",
                    onTap: () {
                      // Get.toNamed(Routes.CAFETERIA_ADD_STAFF, arguments: true);
                      Get.toNamed(Routes.CAFETERIA_STAFF_LIST);
                    },
                  ),
                  CafeteriaSettingWidget(
                    labelName: "History",
                    onTap: () {
                      print("object Pressed");
                    },
                  ),
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
                      print("object Pressed");
                    },
                  ),
                ],
              );
            }
          ),
        )
        // body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        //   Expanded(
        //     child: Obx(
        //       () => IndexedStack(
        //         index: controller
        //             .selectedIndex.value, // Bind the selected index to controller
        //         children: [
        //           GetBuilder<CafeteriaSettingsController>(
        //             init: CafeteriaSettingsController(),
        //             builder: (controller) => const CafeteriaSettingsView(),
        //           ),
        //           const ProfileView(),
        //           GetBuilder<CafeteriaAddStaffController>(
        //               init: CafeteriaAddStaffController(),
        //               builder: (controller)=> const CafeteriaAddStaffView()
        //
        //           ),
        //           const CafeteriaStaffListView(),
        //           // GetBuilder<CafeteriaAddStaffController>(
        //           //   init: CafeteriaAddStaffController(),
        //           //   builder: (controller)=> const CafeteriaAddStaffView(
        //           //   isEdit: true,
        //           // ),),
        //           const CafeteriaAddStaffView(
        //             isEdit: true,
        //           ),
        //           const CafeteriaHistoryListView(),
        //         ],
        //       ),
        //     ),
        //   ),
        // ]),
        );
  }
}
