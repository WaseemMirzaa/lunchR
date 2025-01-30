import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:luncher/widgets/custom_dialog_schedule.dart';

import 'app/routes/app_pages.dart';

void main() {
  Get.put(ScheduleDialogController());
  runApp(
    GetMaterialApp(
      title: "LunchR",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
