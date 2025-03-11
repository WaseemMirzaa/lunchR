//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class ParentsChildrenDetailsController extends GetxController {
//   // Observable for selected option (whether all children are in the same school)
//   RxBool isSameSchool = false.obs;
//
//   // Number of children
//   RxInt numberOfChildren = 0.obs;
//
//   // List of controllers for child's data
//   RxList<TextEditingController> nameControllers = <TextEditingController>[].obs;
//   RxList<TextEditingController> idControllers = <TextEditingController>[].obs;
//
//   // Single school name controller (as it applies to all children)
//   final TextEditingController schoolNameController = TextEditingController();
//
//   @override
//   void onInit() {
//     super.onInit();
//   }
//
//   // Update whether all children are in the same school
//   void updateSameSchoolOption(bool value) {
//     isSameSchool.value = value;
//
//     if (value && idControllers.isNotEmpty) {
//       // Sync all IDs to the first controller's value when set to 'Yes'
//       String firstId = idControllers.first.text;
//       for (var controller in idControllers) {
//         controller.text = firstId;
//       }
//     }
//   }
//
//   // Sync school IDs across all controllers when `isSameSchool` is true
//   void syncSchoolIds(String newValue, int sourceIndex) {
//     if (isSameSchool.value) {
//       for (int i = 0; i < idControllers.length; i++) {
//         if (i != sourceIndex) {
//           idControllers[i].text = newValue;
//         }
//       }
//     }
//   }
//
//   // Add a new child entry
//   void addChild() {
//     var nameController = TextEditingController();
//     var idController = TextEditingController();
//
//     // Add listener to sync school IDs if required
//     final int currentIndex = idControllers.length;
//     idController.addListener(() {
//       if (isSameSchool.value) {
//         syncSchoolIds(idController.text, currentIndex);
//       }
//     });
//
//     nameControllers.add(nameController);
//     idControllers.add(idController);
//     numberOfChildren.value++;
//   }
//
//   // Remove the last child entry
//   void removeChild() {
//     if (numberOfChildren.value > 0) {
//       nameControllers.last.dispose();
//       idControllers.last.dispose();
//
//       nameControllers.removeLast();
//       idControllers.removeLast();
//       numberOfChildren.value--;
//     }
//   }
//
//   @override
//   void onClose() {
//     // Dispose controllers
//     for (var controller in nameControllers) {
//       controller.dispose();
//     }
//     for (var controller in idControllers) {
//       controller.dispose();
//     }
//     schoolNameController.dispose();
//
//     super.onClose();
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luncher/services/parents/add_children_service.dart';

class ParentsChildrenDetailsController extends GetxController {
  final AddChildrenService addChildrenService = AddChildrenService();

  // Observable for selected option for classroom delivery
  RxString selectedClassRoomDeliveryOption = 'No'.obs;

  // Initialize with 0 children
  RxInt numberOfChildren = 0.obs;
  RxBool allChildrenSameSchool = true.obs; // Default to true


  // List of controllers for child-specific data
  RxList<TextEditingController> nameControllers = <TextEditingController>[].obs;
  RxList<TextEditingController> idControllers = <TextEditingController>[].obs;
  RxList<File?> images = <File?>[].obs;// List to store images
  // var imagesUrl = [].obs;
  RxList<TextEditingController> schoolNameControllerList = <TextEditingController>[].obs;

  final TextEditingController schoolNameController = TextEditingController();
  RxList<String> schoolNamesList = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSchoolNames();
    // initializeControllers(numberOfChildren.value);

    // No initial controllers - they'll be added when incrementChildren is called
  }
  // void initializeControllers(int numberOfChildren) {
  //   nameControllers.clear();
  //   idControllers.clear();
  //   images.clear(); // Clear images list
  //
  //   for (int i = 0; i < numberOfChildren; i++) {
  //     nameControllers.add(TextEditingController());
  //     idControllers.add(TextEditingController());
  //     images.add(null); // Initialize images list with null
  //   }
  // }

  void printChildrenData() {
    print("---- Children Data ----");
    for (int i = 0; i < nameControllers.length; i++) {
      print("Child ${i + 1}: Name = ${nameControllers[i].text}, School ID = ${idControllers[i].text}, School Name = ${schoolNameControllerList[i].text}");
      print("  Image = ${images[i]?.path ?? "No Image Selected"}");

    }
  }

  Future<void> pickImage(int index) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Ensure list has enough elements before assigning
      while (images.length <= index) {
        images.add(null);
       // imagesUrl.add(null);
      }

      images[index] = File(pickedFile.path); // Assign image safely
      print("Image Selected for Child ${index + 1}: ${pickedFile.path}");
      // imagesUrl.value = imagesUrl[index];
      update(); // Update UI
    }
  }
  // Fetch school names and update observable list
  Future<void> fetchSchoolNames() async {
    List<String> schools = await addChildrenService.getSchoolNames();
    schoolNamesList.assignAll(schools);

    // Print the fetched list
    print("Fetched School Names: $schoolNamesList");
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
    var schoolNameController = TextEditingController();

    File? imageFile; // Nullable File object
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
    schoolNameControllerList.add(schoolNameController);
    // Add image file if it's not null
    if (imageFile != null) {
      images.add(imageFile);
    } else {
      images.add(File('')); // Add an empty file if no image is selected
    }
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
      if (schoolNameControllerList.isNotEmpty) {
        schoolNameControllerList.last.dispose();
        schoolNameControllerList.removeLast();
      }
      // if (images.isNotEmpty) {
      //   images.last?.delete();
      //   images.removeLast();
      // }
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
    for (var controller in schoolNameControllerList) {
      controller.dispose();
    }
    images.clear();

    super.onClose();
  }
}
