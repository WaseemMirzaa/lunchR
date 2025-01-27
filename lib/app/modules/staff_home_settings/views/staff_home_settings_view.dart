import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:luncher/app/modules/profile/views/profile_view.dart';
import 'package:luncher/app/modules/staff_history_calender/views/staff_history_calender_view.dart';
import 'package:luncher/app/modules/staff_profile/views/staff_profile_view.dart';
import 'package:luncher/app/modules/staff_settings/views/staff_settings_view.dart';

import '../controllers/staff_home_settings_controller.dart';

class StaffHomeSettingsView extends GetView<StaffHomeSettingsController> {
  const StaffHomeSettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Expanded(
          child: Obx(
            () => IndexedStack(
              index: controller
                  .selectedIndex.value, // Bind the selected index to controller
              children: const [
                // First child
                StaffSettingsView(),

                // Third child
                StaffProfileView(),

                StaffHistoryCalenderView(),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
