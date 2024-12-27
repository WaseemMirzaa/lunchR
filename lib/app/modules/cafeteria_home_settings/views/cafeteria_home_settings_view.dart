import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:luncher/app/modules/cafeteria_profile/views/cafeteria_profile_view.dart';
import 'package:luncher/app/modules/cafeteria_settings/views/cafeteria_settings_view.dart';

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
                // First child
                CafeteriaSettingsView(),

                // Third child
                CafeteriaProfileView(),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
