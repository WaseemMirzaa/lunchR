import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:luncher/config/appBuilderId.dart';
import 'package:luncher/config/app_const.dart';
import 'package:luncher/models/parents_models/add_children.dart';
import 'package:luncher/services/cefeteria_admin_services/cafateria_history_selectdate_service.dart';
import 'package:intl/intl.dart';

class CafeteriaHistorySelectDateController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final CafaterisHistorySelectDateService cafaterisHistorySelectDateService =
      CafaterisHistorySelectDateService();

  //TODO: Implement CafeteriaHistorySelectDateController

  final count = 0.obs;
  var isLoading = false.obs;
  String? cafateriaAdminName;
  var childrenList = <ParentsAddChildren>[].obs;

  @override
  void onInit() async {
    await fetchCafateriaName();
    fetchCafateriaChildren();
    super.onInit();
  }

  Future<void> fetchCafateriaName() async {
    final user = _auth.currentUser;
    // Fetch user document from Firestore
    DocumentSnapshot<Map<String, dynamic>> userDoc = await _firestore
        .collection(CollectionKey.USER_COLLECTION)
        .doc(user?.uid)
        .get();
    print("user value documents  ${userDoc.exists}");
    final cafaeteriaName = userDoc.data()?['cafeteriaName'] as String?;
    print("Cafateria nama is :${cafaeteriaName}");
    cafateriaAdminName = cafaeteriaName;
  }

  bool checkIfDateHasMeal(DateTime day) {
    print("🔍 Checking meals for day: $day");

    // ✅ Extract meal dates from backend
    List<DateTime> savedDates = childrenList
        .map((child) => child.date != null ? DateTime.parse(child.date!) : null)
        .whereType<DateTime>()
        .toList();

    // for (var savedDate in savedDates) {
    //   bool isSame = isSameDay(savedDate, day);
    //   print(
    //       "✅ Checking saved date: $savedDate with day: $day => Match: $isSame");
    //
    //   if (isSame) {
    //     print("✅ Meal found on exact date: LLLL $day");
    //     return true;
    //   }
    // }

    // ✅ Check for repeated weekly schedules from the backend
    // for (var child in childrenList) {
    //   for (var meal in child.selectedMealMenuData ?? []) {
    //     var schedule = meal.schedule;
    //
    //     if (schedule != null &&
    //         schedule.repeatEvery == 'week' &&
    //         schedule.repeatCount== 1 &&
    //         schedule.repeatOn != null) {
    //       List<String> repeatOnDays = List<String>.from(schedule.repeatOn!);
    //       print("🔄 RepeatOn days from backend: $repeatOnDays");
    //
    //       // ✅ Normalize weekday formatting
    //       String date2 = DateFormat('EEEE').format(day).trim();
    //       repeatOnDays = repeatOnDays
    //           .map((d) => d.trim())
    //           .toList(); // Remove unwanted spaces
    //
    //       print("🔍 Checking if $date2 is in $repeatOnDays");
    //
    //       if (repeatOnDays.contains(date2)) {
    //         print("✅ Meal Found! Matching Repeat Day: $date2");
    //         return true;
    //       }
    //     }
    //   }
    // }
    for (var child in childrenList) {
      for (var meal in child.selectedMealMenuData ?? []) {
        var schedule = meal.schedule;

        if (schedule != null &&
            schedule.repeatEvery == 'week' &&
            schedule.repeatOn != null) {

          List<String> repeatOnDays = List<String>.from(schedule.repeatOn!);
          String date2 = DateFormat('EEEE').format(day).trim();
          print("object dataeadf $date2");
          repeatOnDays = repeatOnDays.map((d) => d.trim()).toList();

          // ✅ Get the saved date for this meal
          DateTime? savedDate = childrenList
              .map((child) => child.date != null ? DateTime.parse(child.date!) : null)
              .whereType<DateTime>()
              .toList()
              .firstOrNull; // Get the first saved date

          for (var savedDate in savedDates) {
            if (savedDate != null) {
              int weeksDifference = day
                  .difference(savedDate)
                  .inDays ~/ 7; // Get week difference

              // ✅ Ensure the date is NOT before the earliest saved date
              if (!day.isBefore(savedDate) && repeatOnDays.contains(date2) &&
                  weeksDifference < int.parse(schedule.repeatCount!)) {
                print(
                    "✅ Meal Found! Matching Repeat Day: $date2 after $savedDate");
                return true;
              }
            }
          }
        }
      }
    }
    print("❌ No meal found for this date: $day");
    return false; // ❌ No meal found for this date
  }

  ///Check if two dates are the same (ignores time)**
  bool isSameDay(DateTime date1, DateTime date2) {
    DateTime normalizedDate1 = DateTime(date1.year, date1.month, date1.day);
    DateTime normalizedDate2 = DateTime(date2.year, date2.month, date2.day);

    print("✅ Checking exact date match: $normalizedDate1 , $normalizedDate2");

    return normalizedDate1.isAtSameMomentAs(normalizedDate2);
  }

  ///Get weekday name from DateTime**
  String getWeekdayName(DateTime date) {
    return [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ][date.weekday - 1]
        .trim(); // Ensure correct indexing and remove any extra spaces
  }

  ///Get the next occurrence of a specific weekday after a given date**
  Future<void> fetchCafateriaChildren() async {
    isLoading.value = true;

    List<ParentsAddChildren> children = await cafaterisHistorySelectDateService
        .fetchChildrenByCafateriaName(cafateriaAdminName!);
    childrenList.assignAll(children);
    print("children data is  $children");

    isLoading.value = false;
    update(['cafateriaHistorySelectDataId']);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
