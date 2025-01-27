import 'package:get/get.dart';

import '../controllers/staff_settings_controller.dart';

class StaffSettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StaffSettingsController>(
      () => StaffSettingsController(),
    );
  }
}
