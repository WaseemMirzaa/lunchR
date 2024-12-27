import 'package:get/get.dart';

import '../controllers/cafeteria_cafeteria_detail_controller.dart';

class CafeteriaCafeteriaDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CafeteriaCafeteriaDetailController>(
      () => CafeteriaCafeteriaDetailController(),
    );
  }
}
