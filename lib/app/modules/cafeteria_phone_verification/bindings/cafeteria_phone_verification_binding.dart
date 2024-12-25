import 'package:get/get.dart';

import '../controllers/cafeteria_phone_verification_controller.dart';

class CafeteriaPhoneVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CafeteriaPhoneVerificationController>(
      () => CafeteriaPhoneVerificationController(),
    );
  }
}
