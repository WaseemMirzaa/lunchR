import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ParentsChildrenDetailsController extends GetxController {
  // Observable for selected meal option
  RxString selectedClassRoomDeliveryOption = 'No'.obs;

  // Update the selected option
  void updateClassRoomDeliveryOption(String option) {
    selectedClassRoomDeliveryOption.value = option;
  }

  RxInt numberOfChildren = 1.obs;

  // List of controllers for child-specific data
  RxList<TextEditingController> nameControllers = <TextEditingController>[].obs;
  RxList<TextEditingController> idControllers = <TextEditingController>[].obs;

  void incrementChildren() {
    numberOfChildren++;
    nameControllers.add(TextEditingController());
    idControllers.add(TextEditingController());
  }

  void decrementChildren() {
    if (numberOfChildren > 0) {
      numberOfChildren--;
      nameControllers.removeLast();
      idControllers.removeLast();
    }
  }
}
