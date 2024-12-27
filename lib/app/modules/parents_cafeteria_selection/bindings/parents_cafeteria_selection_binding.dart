import 'package:get/get.dart';

import '../controllers/parents_cafeteria_selection_controller.dart';

class ParentsCafeteriaSelectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ParentsCafeteriaSelectionController>(
      () => ParentsCafeteriaSelectionController(),
    );
  }
}
