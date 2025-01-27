import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ParentsChildrenDetailsController extends GetxController {
  // Observable for selected option for classroom delivery
  RxString selectedClassRoomDeliveryOption = 'No'.obs;

  // Initialize with 0 children
  RxInt numberOfChildren = 0.obs;

  // List of controllers for child-specific data
  RxList<TextEditingController> nameControllers = <TextEditingController>[].obs;
  RxList<TextEditingController> idControllers = <TextEditingController>[].obs;

  final TextEditingController schoolNameController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // No initial controllers - they'll be added when incrementChildren is called
  }

  // Update the selected option
  void updateClassRoomDeliveryOption(String option) {
    selectedClassRoomDeliveryOption.value = option;
    // When switching to 'Yes', sync all IDs to the first controller's value
    if (option == 'Yes' && idControllers.isNotEmpty) {
      String firstId = idControllers[0].text;
      for (var controller in idControllers) {
        if (controller != idControllers[0]) {
          controller.text = firstId;
        }
      }
    }
  }

  // Method to sync school IDs across all controllers
  void syncSchoolIds(String newValue, int sourceIndex) {
    if (selectedClassRoomDeliveryOption.value == 'Yes') {
      for (int i = 0; i < idControllers.length; i++) {
        if (i != sourceIndex) {
          idControllers[i].text = newValue;
        }
      }
    }
  }

  void incrementChildren() {
    var nameController = TextEditingController();
    var idController = TextEditingController();

    // Add listener to the new ID controller
    final int currentIndex = idControllers.length;
    idController.addListener(() {
      if (selectedClassRoomDeliveryOption.value == 'Yes') {
        String newValue = idController.text;
        syncSchoolIds(newValue, currentIndex);
      }
    });

    nameControllers.add(nameController);
    idControllers.add(idController);
    numberOfChildren++;
  }

  void decrementChildren() {
    if (numberOfChildren > 0) {
      if (nameControllers.isNotEmpty) {
        nameControllers.last.dispose();
        nameControllers.removeLast();
      }
      if (idControllers.isNotEmpty) {
        idControllers.last.dispose();
        idControllers.removeLast();
      }
      numberOfChildren--;
    }
  }

  @override
  void onClose() {
    for (var controller in nameControllers) {
      controller.dispose();
    }
    for (var controller in idControllers) {
      controller.dispose();
    }
    super.onClose();
  }
}
