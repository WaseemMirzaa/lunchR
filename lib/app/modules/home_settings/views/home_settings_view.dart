import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:luncher/app/modules/profile/views/profile_view.dart';
import 'package:luncher/app/modules/settings/views/settings_view.dart';

import '../controllers/home_settings_controller.dart';

class HomeSettingsView extends GetView<HomeSettingsController> {
  const HomeSettingsView({super.key});
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
                SettingsView(),

                // Third child
                ProfileView(),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
