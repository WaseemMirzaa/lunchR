import 'package:get/get.dart';

import '../controllers/cafeteria_child_verification_info_controller.dart';

class CafeteriaChildVerificationInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CafeteriaChildVerificationInfoController>(
      () => CafeteriaChildVerificationInfoController(),
    );
  }
}
