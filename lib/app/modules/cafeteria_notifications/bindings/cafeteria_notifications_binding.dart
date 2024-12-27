import 'package:get/get.dart';

import '../controllers/cafeteria_notifications_controller.dart';

class CafeteriaNotificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CafeteriaNotificationsController>(
      () => CafeteriaNotificationsController(),
    );
  }
}
