import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:luncher/app/modules/cafeteria_add_staff/views/cafeteria_add_staff_view.dart';
import 'package:luncher/app/modules/cafeteria_history_list/views/cafeteria_history_list_view.dart';
import 'package:luncher/app/modules/cafeteria_settings/views/cafeteria_settings_view.dart';
import 'package:luncher/app/modules/cafeteria_staff_list/views/cafeteria_staff_list_view.dart';
import 'package:luncher/app/modules/profile/views/profile_view.dart';

import '../controllers/cafeteria_home_settings_controller.dart';

class CafeteriaHomeSettingsView
    extends GetView<CafeteriaHomeSettingsController> {
  const CafeteriaHomeSettingsView({super.key});
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
                CafeteriaSettingsView(),
                ProfileView(),
                CafeteriaAddStaffView(),
                CafeteriaStaffListView(),
                CafeteriaAddStaffView(
                  isEdit: true,
                ),
                CafeteriaHistoryListView(),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
