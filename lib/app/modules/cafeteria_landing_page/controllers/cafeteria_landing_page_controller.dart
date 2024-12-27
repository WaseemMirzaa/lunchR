import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luncher/app/modules/cafeteria_child_verification_home/controllers/cafeteria_child_verification_home_controller.dart';
import 'package:luncher/app/modules/cafeteria_child_verification_home/views/cafeteria_child_verification_home_view.dart';
import 'package:luncher/app/modules/cafeteria_history/controllers/cafeteria_history_controller.dart';
import 'package:luncher/app/modules/cafeteria_history/views/cafeteria_history_view.dart';
import 'package:luncher/app/modules/cafeteria_meal_selection/controllers/cafeteria_meal_selection_controller.dart';
import 'package:luncher/app/modules/cafeteria_meal_selection/views/cafeteria_meal_selection_view.dart';

import 'package:luncher/app/modules/home_settings/controllers/home_settings_controller.dart';
import 'package:luncher/app/modules/home_settings/views/home_settings_view.dart';
import 'package:luncher/app/modules/notifications/controllers/notifications_controller.dart';
import 'package:luncher/app/modules/notifications/views/notifications_view.dart';


class CafeteriaLandingPageController extends GetxController {
  final List<String> imagePaths = [
    'assets/icon/home.png',
    'assets/icon/file.png',
    'assets/icon/idcard.png',
    'assets/icon/active.png',
    'assets/icon/settings.png',
  ];

  final List<Widget> screens = [
    GetBuilder<CafeteriaMealSelectionController>(
      init: CafeteriaMealSelectionController(),
      builder: (_) => const CafeteriaMealSelectionView(),
    ),
    GetBuilder<CafeteriaHistoryController>(
      init: CafeteriaHistoryController(),
      builder: (_) => const CafeteriaHistoryView(),
    ),
    GetBuilder<CafeteriaChildVerificationHomeController>(
      init: CafeteriaChildVerificationHomeController(),
      builder: (_) => const CafeteriaChildVerificationHomeView(),
    ),
    GetBuilder<NotificationsController>(
      init: NotificationsController(),
      builder: (_) => const NotificationsView(),
    ),
    GetBuilder<HomeSettingsController>(
      init: HomeSettingsController(),
      builder: (_) => const HomeSettingsView(),
    ),
  ];

  // Selected index (Reactive variable)
  var selectedIndex = 0.obs;

  // Function to update the selected index
  void onItemTapped(int index) {
    selectedIndex.value = index;
  }
}
