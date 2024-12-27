import 'package:get/get.dart';

import '../controllers/cafeteria_meal_selection_controller.dart';

class CafeteriaMealSelectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CafeteriaMealSelectionController>(
      () => CafeteriaMealSelectionController(),
    );
  }
}
