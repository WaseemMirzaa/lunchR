import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:luncher/app/modules/parents_children_details/controllers/parents_children_details_controller.dart';
import 'package:luncher/app/routes/app_pages.dart';
import 'package:luncher/models/cefeteria_admin/meal_model.dart';
import 'package:luncher/models/cefeteria_admin/meal_shedule_model.dart';
import 'package:luncher/models/parents_models/add_children.dart';
import 'package:luncher/models/parents_models/parent_selected_meals.dart';
import 'package:luncher/services/parents/add_children_service.dart';
import 'package:luncher/services/parents/school_cafaterias_model.dart';

import '../../../../widgets/custom_dialog_schedule.dart';

class ChildrenDetailsController extends GetxController {
  final AddChildrenService addChildrenService = AddChildrenService();
  // Observable for selected payment option
  RxString selectedPaymentOption = 'Meal Selection'.obs;
  late ScheduleDialogController scheduleController;
  var isLoading = false.obs;
  // Observable for selected meal option
  RxString selectedClassRoomDeliveryOption = 'No'.obs;

  // ==  === previous screen collected data
  var cafeModel = <CafeteriaDetailsParents>[]; // Initialize list
  var meals = <MealModel>[].obs;
  var scheduleData = <MealSheduleModel>[].obs;
  var selectedMealData = <ParentSelectedMeals>[].obs;
  // ============ main model for saving children data ============
  ParentsAddChildren parentsAddChildren = ParentsAddChildren();
// ============ main model for saving children data ============
// ============ Getting Data From Parent Controller  ============
  final ParentsChildrenDetailsController parentController =
      Get.find<ParentsChildrenDetailsController>();
  var noOfChildren = 0.obs;
  var allChildrenAreInSameSchool = false.obs;

  // ============ Getting Data From Parent Controller  ============

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      // Assign arguments to existing observable lists
      var receivedSchedule = Get.arguments['scheduleModel'] as List<MealSheduleModel>?;
      var receivedCafe = Get.arguments['cafeModel'] as List<CafeteriaDetailsParents>?;
      var receivedMeal = Get.arguments['mealList'] as List<MealModel>?;

      // ✅ Fix: Retrieve selectedMealData as a list
      var receivedSelectedMeal = Get.arguments['selectedMealData'] as List<ParentSelectedMeals>?;

      if (receivedSelectedMeal != null) {
        selectedMealData.assignAll(receivedSelectedMeal); // Assign data to observable list
      }

      if (receivedSchedule != null) {
        scheduleData.assignAll(receivedSchedule); // Assign data to observable list
      }

      if (receivedCafe != null) {
        cafeModel.assignAll(receivedCafe);
      }
      if (receivedMeal != null) {
        meals.assignAll(receivedMeal);
      }
    }
    scheduleController = Get.find<ScheduleDialogController>();
  }

// ============  saving children data ============
  Future<void> addChildren() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    print("user id is ${user!.uid}");
    print("user id is ${parentController.allChildrenSameSchool.value}");
    print("parentController.cafeteriaNameList[0] id is ${parentController.cafeteriaNameList[0]}");
    var isSuccess = false.obs;

    isLoading.value = true;
    parentsAddChildren = ParentsAddChildren(
      parentId: user.uid,
      classroomDelivery:selectedClassRoomDeliveryOption.value ,
      numberOfChildren: parentController.numberOfChildren.value.toString(),
      allChildrenAreInSameSchool: parentController.selectedClassRoomDeliveryOption.value,
      childId: DateTime.now().millisecondsSinceEpoch.toString(),
      childName: parentController.nameControllers[0].text,
      childSchoolID: parentController.idControllers[0].text,
      childImageUrl: parentController.images[0].toString(),
      schoolName: parentController.schoolNameController.text,
      cafeteriaName: parentController.cafeteriaNameList[0],
      selectedMealMenuData: selectedMealData.isNotEmpty ? selectedMealData : null,
    );
    isSuccess.value = await addChildrenService.addChildren(parentsAddChildren);
    isLoading.value = false;

    if (isSuccess.value) {
      Get.offAllNamed(
        Routes.PARENTS_CHILDREN_DETAILS,
        arguments: {
          'isAddedMenuItems': true, // Pass the parameter here
        },
      );
      Get.snackbar("Success", "Child added successfully!");
    } else {
      Get.snackbar("Error", "Failed to add child. Please try again.");
    }
    isLoading.value = false;

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


  // Update the selected option
  void updateClassRoomDeliveryOption(String option) {
    selectedClassRoomDeliveryOption.value = option;
  }
}
