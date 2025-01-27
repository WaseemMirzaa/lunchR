import 'package:get/get.dart';

import '../controllers/staff_phone_verification_controller.dart';

class StaffPhoneVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StaffPhoneVerificationController>(
      () => StaffPhoneVerificationController(),
    );
  }
}
