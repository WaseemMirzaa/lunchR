import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:luncher/widgets/custom_dialog_schedule.dart';
import 'package:luncher/widgets/custom_shedule_dialog.dart';

import 'app/modules/home_settings/controllers/home_settings_controller.dart';
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';
import 'package:luncher/app/modules/staff_phone_verification/controllers/staff_phone_verification_controller.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Get.put(ScheduleDialogController());
  Get.put(ScheduleSelectedDialogController()); // Register the controller
  Get.put(StaffPhoneVerificationController());

  runApp(
    GetMaterialApp(
      title: "Snack Tag",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
