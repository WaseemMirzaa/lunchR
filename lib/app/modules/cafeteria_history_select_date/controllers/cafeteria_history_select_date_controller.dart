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

//   bool checkIfDateHasMeal(DateTime day) {
//     for (var child in childrenList) {
//       if (child.selectedMealMenuData == null || child.selectedMealMenuData!.isEmpty) {
//         continue;
//       }
//
//       // Parse the initial order date from child data
//       DateTime orderDate;
//       try {
//         orderDate = DateTime.parse(child.date!);
//         // Normalize order date to start of day
//         orderDate = DateTime(orderDate.year, orderDate.month, orderDate.day);
//       } catch (e) {
//         print("Error parsing date: ${child.date}");
//         continue;
//       }
//
//       // Normalize check day to start of day
//       day = DateTime(day.year, day.month, day.day);
//
//       for (var mealData in child.selectedMealMenuData!) {
//         var schedule = mealData.schedule;
//
//         if (schedule == null ||
//             schedule.repeatOn == null ||
//             schedule.repeatEvery != 'week' ||
//             schedule.repeatCount == null) {
//           continue;
//         }
//
//         // Get weekday name of the current day being checked
//         String currentDayName = DateFormat('EEEE').format(day);
//
//         // Clean up the repeatOn list to handle potential spaces
//         List<String> scheduledDays = schedule.repeatOn!
//             .map((d) => d.trim())
//             .toList();
//
//         // Check if this day's name is in the repeatOn list
//         bool isDayScheduled = scheduledDays.contains(currentDayName);
// print("order date $orderDate");
// print("day is $day");
// print("current day name $currentDayName");
// print("scheduled days $scheduledDays");
// print("is day scheduled $isDayScheduled");
//         if (isDayScheduled) {
//           // Only proceed if the day is after or equal to the order date
//           if (day.compareTo(orderDate) >= 0) {
//             // Calculate the start of the week for both dates
//             DateTime orderWeekStart = orderDate.subtract(Duration(days: orderDate.weekday - 1));
//             DateTime checkWeekStart = day.subtract(Duration(days: day.weekday - 1));
//
//             // Calculate week difference
//             int weeksDifference = checkWeekStart.difference(orderWeekStart).inDays ~/ 7;
//
//             // Get repeat count as integer (default to 1 if parsing fails)
//             int repeatCount = int.tryParse(schedule.repeatCount!) ?? 1;
//
//             // Check if we're within the repeat period
//             if (weeksDifference < repeatCount) {
//               print("✅ Found meal for $currentDayName on ${day.toString()} - Week ${weeksDifference + 1} of $repeatCount");
//               return true;
//             }
//           }
//         }
//       }
//     }
//
//     return false;
//   }
  bool checkIfDateHasMeal(DateTime day) {
  for (var child in childrenList) {
    if (child.selectedMealMenuData == null ||
        child.selectedMealMenuData!.isEmpty) {
      continue;
    }

    // Parse the initial order date from child data
    DateTime orderDate;
    try {
      orderDate = DateTime.parse(child.date!);
      // Normalize order date to start of day
      orderDate = DateTime(orderDate.year, orderDate.month, orderDate.day);
    } catch (e) {
      print("Error parsing date: ${child.date}");
      continue;
    }

    // Normalize check day to start of day
    day = DateTime(day.year, day.month, day.day);

    for (var mealData in child.selectedMealMenuData!) {
      var schedule = mealData.schedule;

      if (schedule == null ||
          schedule.repeatOn == null ||
          schedule.repeatEvery != 'week' ||
          schedule.repeatCount == null) {
        continue;
      }

      // Get weekday name of the current day being checked
      String currentDayName = DateFormat('EEEE').format(day);

      // Clean up the repeatOn list to handle potential spaces
      List<String> scheduledDays =
          schedule.repeatOn!.map((d) => d.trim()).toList();

      // Check if this day's name is in the repeatOn list
      bool isDayScheduled = scheduledDays.contains(currentDayName);
      print("order date $orderDate");
print("day is $day");
print("current day name $currentDayName");
print("scheduled days $scheduledDays");
print("is day scheduled $isDayScheduled");
      if (isDayScheduled) {
        // Ensure the current day is **on or after** the order date
        if (day.compareTo(orderDate) >= 0) {
          // ✅ Calculate the exact **week number** since `orderDate`
          int daysSinceStart = day.difference(orderDate).inDays;
          int weekNumber = daysSinceStart ~/ 7; // Number of completed weeks

          // ✅ Convert `repeatCount` to integer (default to 1 if parsing fails)
          int repeatCount = int.tryParse(schedule.repeatCount!) ?? 1;

          // ✅ Ensure the meal appears only on **scheduled days in weekly intervals**
          if (weekNumber < repeatCount) {
            print(
                "✅ Meal scheduled on $currentDayName (${day.toString()}) - Week ${weekNumber + 1} of $repeatCount");
            return true;
          }
        }
      }
    }
  }
  return false;
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
