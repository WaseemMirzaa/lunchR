import 'package:get/get.dart';

import '../controllers/staff_history_controller.dart';

class StaffHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StaffHistoryController>(
      () => StaffHistoryController(),
    );
  }
}
