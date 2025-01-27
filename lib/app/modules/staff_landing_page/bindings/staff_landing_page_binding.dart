import 'package:get/get.dart';

import '../controllers/staff_landing_page_controller.dart';

class StaffLandingPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StaffLandingPageController>(
      () => StaffLandingPageController(),
    );
  }
}
