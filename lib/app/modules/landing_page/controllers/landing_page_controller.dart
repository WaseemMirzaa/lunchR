import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luncher/app/modules/home_settings/controllers/home_settings_controller.dart';
import 'package:luncher/app/modules/home_settings/views/home_settings_view.dart';
import 'package:luncher/app/modules/notifications/controllers/notifications_controller.dart';
import 'package:luncher/app/modules/notifications/views/notifications_view.dart';
import 'package:luncher/app/modules/parents_history/controllers/parents_history_controller.dart';
import 'package:luncher/app/modules/parents_history/views/parents_history_view.dart';
import 'package:luncher/app/modules/parents_home/controllers/parents_home_controller.dart';
import 'package:luncher/app/modules/parents_home/views/parents_home_view.dart';

class LandingPageController extends GetxController {
  final List<String> images = [
    'assets/icon/home.png',
    'assets/icon/file.png',
    'assets/icon/active.png',
    'assets/icon/settings.png',
  ];

  final List<Widget> screens = [
    GetBuilder<ParentsHomeController>(
      init: ParentsHomeController(),
      builder: (_) => const ParentsHomeView(),
    ),
    GetBuilder<ParentsHistoryController>(
      init: ParentsHistoryController(),
      builder: (_) => const ParentsHistoryView(),
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
