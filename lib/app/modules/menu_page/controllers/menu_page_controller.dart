import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luncher/models/cefeteria_admin/meal_model.dart';
import 'package:luncher/models/cefeteria_admin/meal_shedule_model.dart';
import 'package:luncher/services/parents/add_children_service.dart';
import 'package:luncher/services/parents/school_cafaterias_model.dart';

class MenuPageController extends GetxController {
  //TODO: Implement CafeteriaController
final AddChildrenService addChildrenService = AddChildrenService();
  var selectedIndexes = <int>{}.obs;
  var scheduleModel = <MealSheduleModel>[].obs;
  var cafeteriaId = ''.obs;
  var isLoading = false.obs;
  var meals = <MealModel>[].obs;
var searchText = "".obs;
var filteredMeals = <MealModel>[].obs;
var isDataFound = false.obs;
var cafeModel = <CafeteriaDetailsParents>[];
var scheduleStatementList = <String>[].obs;
// Initialize list


  TextEditingController searchTextController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      cafeteriaId.value = Get.arguments['userID']; // Retrieve userID
      cafeModel = List<CafeteriaDetailsParents>.from(
          Get.arguments['cafeModel'] ?? []);
    }
    for (var cafe in cafeModel) {
      print("Cafeteria Details:");
      print("ID: ${cafe.id}");
      print("School Name: ${cafe.schoolName}");
      print("Cafeteria Name: ${cafe.cafeteriaName}");
      print("Image URL: ${cafe.img}");
      print("-----------------------------");
    }
print("cafeteria user id: ${cafeteriaId.value}");
    fetchMeals();
  }
  void fetchMeals() {
    isLoading.value = true;
    // String userId = FirebaseAuth.instance.currentUser?.uid ?? "";

    // if (userId.isEmpty) {
    //   print("User not logged in");
    //   isLoading.value = false;
    //   return;
    // }

    meals.bindStream(addChildrenService.getMealsByCafeteriaUser(cafeteriaId.value));

    // ever(meals, (_) {
    //   for (var meal in meals) {
    //     if (!switchControllers.containsKey(meal.id)) {
    //       switchControllers[meal.id!] = ValueNotifier<bool>(meal.availability == 'available');
    //     } else {
    //       switchControllers[meal.id]!.value = meal.availability == 'available';
    //     }
    //   }
    //   filterMeals();
    // });
    meals.listen((_) {
      print("Fetched School Data: $meals");
      filterMeals();
      isLoading.value = false; // Set loading to false only after data loads
    });

    isLoading.value = false;
  }

  void filterMeals() {
    if (searchText.value.isEmpty) {
      filteredMeals.assignAll(meals);
      isDataFound.value = false;
    } else {
      filteredMeals.assignAll(meals.where((meal) => meal.name!.toLowerCase().contains(searchText.value.toLowerCase())));
      isDataFound.value = filteredMeals.isEmpty;
    }
  }

void updateSearchText(String text) {
  searchText.value = text;
  filterMeals();
}
}
