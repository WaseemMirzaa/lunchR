import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luncher/models/user_model.dart';
import 'package:luncher/services/parents/add_children_service.dart';

class CafeteriaController extends GetxController {
  final AddChildrenService addChildrenService = AddChildrenService();

  //TODO: Implement CafeteriaController

  var selectedIndexes = <int>{}.obs;
  RxList<Map<String, dynamic>> cafeteriaList = <Map<String, dynamic>>[].obs;
  RxList<UserModel> cafeteriaL = <UserModel>[].obs;
  var schoolName = ''.obs; // Store the school name
  RxList<String> filteredCafeteria = <String>[].obs;
  final TextEditingController textController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (Get.arguments != null && Get.arguments is String) {
      schoolName.value = Get.arguments;
   }

    fetchSchoolCafeteria();
  }


  Future<void> fetchSchoolCafeteria() async {
    cafeteriaList.value = await addChildrenService.getCafeteriaSchool(schoolName.value);
    // schoolNamesList.assignAll(schools);
    convertToUserModel(); // Convert after fetching

    // Print the fetched list
    print("Fetched School Names: ${cafeteriaList[0]}");
  }
  void convertToUserModel() {
    cafeteriaL.assignAll(cafeteriaList.map((e) => UserModel.fromJson(e)).toList());
  }

  void filterSchools() {
    if (textController.text.isEmpty) {
      filteredCafeteria.value =
          cafeteriaList.map((e) => e['cafeteriaName'] as String).toList();
    } else {
      filteredCafeteria.value = cafeteriaList
          .where((cafeteria) =>
      cafeteria['cafeteriaName'] != null &&
          (cafeteria['cafeteriaName'] as String)
              .toLowerCase()
              .contains(textController.text.toLowerCase()))
          .map((e) => e['cafeteriaName'] as String)
          .toList();
    }
  }

}
