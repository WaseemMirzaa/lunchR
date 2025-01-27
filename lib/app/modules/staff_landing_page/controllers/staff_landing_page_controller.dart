import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luncher/app/modules/cafeteria_child_verification_home/controllers/cafeteria_child_verification_home_controller.dart';
import 'package:luncher/app/modules/cafeteria_child_verification_home/views/cafeteria_child_verification_home_view.dart';
import 'package:luncher/app/modules/notifications/controllers/notifications_controller.dart';
import 'package:luncher/app/modules/notifications/views/notifications_view.dart';
import 'package:luncher/app/modules/staff_history/controllers/staff_history_controller.dart';
import 'package:luncher/app/modules/staff_history/views/staff_history_view.dart';
import 'package:luncher/app/modules/staff_home_settings/controllers/staff_home_settings_controller.dart';
import 'package:luncher/app/modules/staff_home_settings/views/staff_home_settings_view.dart';
import 'package:luncher/app/modules/staff_meal_selection/controllers/staff_meal_selection_controller.dart';
import 'package:luncher/app/modules/staff_meal_selection/views/staff_meal_selection_view.dart';

class StaffLandingPageController extends GetxController {
  final List<String> imagePaths = [
    'assets/icon/home.png',
    'assets/icon/file.png',
    'assets/icon/idcard.png',
    'assets/icon/active.png',
    'assets/icon/settings.png',
  ];

  final List<Widget> screens = [
    GetBuilder<StaffMealSelectionController>(
      init: StaffMealSelectionController(),
      builder: (_) => const StaffMealSelectionView(),
    ),
    GetBuilder<StaffHistoryController>(
      init: StaffHistoryController(),
      builder: (_) => const StaffHistoryView(),
    ),
    GetBuilder<CafeteriaChildVerificationHomeController>(
      init: CafeteriaChildVerificationHomeController(),
      builder: (_) => const CafeteriaChildVerificationHomeView(),
    ),
    GetBuilder<NotificationsController>(
      init: NotificationsController(),
      builder: (_) => const NotificationsView(),
    ),
    GetBuilder<StaffHomeSettingsController>(
      init: StaffHomeSettingsController(),
      builder: (_) => const StaffHomeSettingsView(),
    ),
  ];

  // Selected index (Reactive variable)
  var selectedIndex = 0.obs;

  // Function to update the selected index
  void onItemTapped(int index) {
    selectedIndex.value = index;
  }
}
