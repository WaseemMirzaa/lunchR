import 'package:get/get.dart';

import '../controllers/cafeteria_profile_controller.dart';

class CafeteriaProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CafeteriaProfileController>(
      () => CafeteriaProfileController(),
    );
  }
}
