import 'package:get/get.dart';
import 'package:luncher/models/meal_model.dart';
import 'package:luncher/services/meal_service.dart';
import 'dart:io';

class CafeteriaMenuPageController extends GetxController {
  final MealService _mealService = MealService();
  var meals = <MealModel>[].obs;
  var filteredMeals = <MealModel>[].obs; // Filtered list for searching
  var isLoading = false.obs;
  var searchText = "".obs; // Observable for search text

  @override
  void onInit() {
    fetchMeals();
    super.onInit();
  }

  void fetchMeals() {
    isLoading.value = true;

    meals.bindStream(_mealService.getMeals());
    ever(meals, (_) => filterMeals()); // Re-filter when meals update

    isLoading.value = false;
  }

  void filterMeals() {
    if (searchText.value.isEmpty) {
      filteredMeals.assignAll(meals);
    } else {
      filteredMeals.assignAll(meals.where((meal) =>
          meal.name!.toLowerCase().contains(searchText.value.toLowerCase())));
    }
  }

  void updateSearchText(String text) {
    searchText.value = text;
    filterMeals();
  }

  Future<void> addMeal(MealModel meal, File? imageFile) async {
    await _mealService.addMeal(meal, imageFile);
    fetchMeals();
  }

  Future<void> updateMeal(String mealId, Map<String, dynamic> data) async {
    await _mealService.updateMeal(mealId, data);
    fetchMeals();
  }

  Future<void> deleteMeal(String mealId) async {
    await _mealService.deleteMeal(mealId);
    fetchMeals();
  }
}
