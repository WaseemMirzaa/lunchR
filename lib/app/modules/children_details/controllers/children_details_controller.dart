import 'package:get/get.dart';

class ChildrenDetailsController extends GetxController {
  // Observable for selected payment option
  RxString selectedPaymentOption = 'Meal Selection'.obs;

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
