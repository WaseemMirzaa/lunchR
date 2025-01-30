import 'package:get/get.dart';

import '../../../../widgets/custom_dialog_schedule.dart';

class ChildrenDetailsController extends GetxController {
  // Observable for selected payment option
  RxString selectedPaymentOption = 'Meal Selection'.obs;
  late ScheduleDialogController scheduleController;




  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // Get the existing instance of ScheduleDialogController
    scheduleController = Get.find<ScheduleDialogController>();

    // Now you can access values from scheduleController
    print("Selected Days: ${scheduleController.selectedDays}");
    print("Selected Times: ${scheduleController.selectedTimes}");
    print("Repeat Unit: ${scheduleController.repeatUnit.value}");
  }

  // Update the selected option
  void updatePaymentOption(String option) {
    selectedPaymentOption.value = option;
  }

  // Observable for selected meal option
  RxString selectedDurationOption = 'Weekly'.obs;

  // Update the selected option
  void updateDurationOption(String option) {
    selectedDurationOption.value = option;
  }

  // Observable for selected meal option
  RxString selectedClassRoomDeliveryOption = 'No'.obs;

  // Update the selected option
  void updateClassRoomDeliveryOption(String option) {
    selectedClassRoomDeliveryOption.value = option;
  }
}
