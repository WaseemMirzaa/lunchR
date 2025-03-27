import 'package:get/get.dart';

import '../controllers/child_verification_upload_info_controller.dart';

class ChildVerificationUploadInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChildVerificationUploadInfoController>(
      () => ChildVerificationUploadInfoController(),
      fenix: true, // This allows the controller to be reused if needed
    );
  }
}
