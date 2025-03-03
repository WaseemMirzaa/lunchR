import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luncher/models/cefeteria_admin/meal_model.dart';
import 'package:luncher/services/meal_service.dart';
import 'dart:io';

class CafeteriaMenuPageController extends GetxController {
  final MealService _mealService = MealService();
  var meals = <MealModel>[].obs;
  var filteredMeals = <MealModel>[].obs;
  var isdataFound = false.obs;// Filtered list for searching
  var isLoading = false.obs;
  var searchText = "".obs; // Observable for search text
  TextEditingController searchTextController = TextEditingController();
  // final _controller = ValueNotifier<bool>(meals.first.availability == 'available');
  final Map<String, ValueNotifier<bool>> switchControllers = {};

  @override
  void onInit() {
    searchText.value = searchTextController.text;
    fetchMeals();
    super.onInit();
  }

//   void fetchMeals() {
//     isLoading.value = true;
//
//     meals.bindStream(_mealService.getMeals());
//     ever(meals, (_) => filterMeals()); // Re-filter when meals update
// print("sss# ${meals}");
//     isLoading.value = false;
//   }
//   void fetchMeals() {
//     isLoading.value = true;
//
//     // Bind the stream to the 'meals' list
//     meals.bindStream(_mealService.getMeals());
//
//     // Re-filter meals and print when meals update
//     ever(meals, (_) {
//       filterMeals();
//     });
//
//     // Listen to the stream and set loading to false once data is received
//     _mealService.getMeals().listen((snapshot) {
//       if (snapshot.isNotEmpty) {
//         isLoading.value = false; // Set loading to false when data is received
//       }
//       isLoading.value = false; // Set loading to false when data is received
//
//     });  }

  void filterMeals() {

    if (searchText.value.isEmpty) {

      filteredMeals.assignAll(meals);
      isdataFound.value=false;
    } else {
       // Print the updated value of meals
      isdataFound.value = false;

      filteredMeals.assignAll(meals.where((meal) =>
       meal.name!.toLowerCase().contains(searchText.value.toLowerCase().trim())));
      if(searchText.value.isNotEmpty && filteredMeals.isEmpty){
        print("empty");
        isdataFound.value = true;
      }
    }
  }
  void fetchMeals() {
    isLoading.value = true;

    meals.bindStream(_mealService.getMeals());

    ever(meals, (_) {
      for (var meal in meals) {
        if (!switchControllers.containsKey(meal.id)) {
          switchControllers[meal.id!] = ValueNotifier<bool>(meal.availability == 'available');
        } else {
          // ✅ Update the existing switch controller when Firestore data changes
          switchControllers[meal.id]!.value = meal.availability == 'available';
        }
      }
    });

    _mealService.getMeals().listen((snapshot) {
      if (snapshot.isNotEmpty) {

        filteredMeals.value = snapshot;
        meals.value = snapshot;
        isLoading.value = false;

      }
    });
  }

  Future<void> updateMeal(String mealId, bool isAvailable) async {

    await _mealService.updateMeal(mealId, {'availability': isAvailable ? 'available' : 'unavailable'});

    // ✅ Update the switch state immediately in UI
    if (switchControllers.containsKey(mealId)) {
      switchControllers[mealId]!.value = isAvailable;
    }
  }

  void updateSearchText(String text) {
    searchText.value = text;
    isdataFound.value = false;
    print("sss# ${searchText.value}");

    if(text.isEmpty) {

      fetchMeals();
    } else {

      filterMeals();

    }
  }

  Future<void> addMeal(MealModel meal, File? imageFile) async {
    await _mealService.addMeal(meal, imageFile);
    fetchMeals();
  }

  // Future<void> updateMeal(String mealId, Map<String, dynamic> data) async {
  //   await _mealService.updateMeal(mealId, data);
  //   fetchMeals();
  // }

  Future<void> deleteMeal(String mealId) async {
    await _mealService.deleteMeal(mealId);
    fetchMeals();
  }
}
