import 'package:luncher/models/parents_models/parent_selected_meals.dart';

class ParentsAddChildren {
  String? id;
  String? parentId;
  String? numberOfChildren;
  String? allChildrenAreInSameSchool;
  String? classroomDelivery;

  String? childId;
  String? childName;
  String? childSchoolID;
  String? childImageUrl;

  String? schoolName;
  String? cafeteriaName;
  String? date;  // Added date field

  List<ParentSelectedMeals>? selectedMealMenuData; // Changed to List

  ParentsAddChildren({
    this.id,
    this.parentId,
    this.numberOfChildren,
    this.allChildrenAreInSameSchool,
    this.classroomDelivery,
    this.childId,
    this.childName,
    this.childSchoolID,
    this.childImageUrl,
    this.schoolName,
    this.cafeteriaName,
    this.date,  // Initialize date
    this.selectedMealMenuData,
  });

  factory ParentsAddChildren.fromJson(Map<String, dynamic> json) {
    return ParentsAddChildren(
      parentId: json['parentId'],
      id: json['id'],
      numberOfChildren: json['numberOfChildren'],
      classroomDelivery: json['classroomDelivery'],
      allChildrenAreInSameSchool: json['allChildrenAreInSameSchool'],
      childId: json['childId'],
      childName: json['childName'],
      childSchoolID: json['childSchoolID'],
      childImageUrl: json['childImageUrl'],
      schoolName: json['schoolName'],
      cafeteriaName: json['cafeteriaName'],
      date: json['date'],  // Assign date from Firestore
      selectedMealMenuData: json['selectedMealMenuData'] != null
          ? (json['selectedMealMenuData'] as List)
          .map((meal) => ParentSelectedMeals.fromMap(meal))
          .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'parentId': parentId,
      'id': id,
      'numberOfChildren': numberOfChildren,
      'classroomDelivery': classroomDelivery,
      'allChildrenAreInSameSchool': allChildrenAreInSameSchool,
      'childId': childId,
      'childName': childName,
      'childSchoolID': childSchoolID,
      'childImageUrl': childImageUrl,
      'schoolName': schoolName,
      'cafeteriaName': cafeteriaName,
      'date': date ?? DateTime.now().toIso8601String(),  // Save current date if not provided
      'selectedMealMenuData': selectedMealMenuData?.map((meal) => meal.toMap()).toList(),
    };
  }
}

// import 'package:luncher/models/parents_models/parent_selected_meals.dart';
//
// class ParentsAddChildren {
//    String? id;
//    String? parentId;
//    String? numberOfChildren;
//    String? allChildrenAreInSameSchool;
//    String? classroomDelivery;
//
//    String? childId;
//    String? childName;
//    String? childSchoolID;
//    String? childImageUrl;
//
//    String? schoolName;
//    String? cafeteriaName;
//
//    List<ParentSelectedMeals>? selectedMealMenuData; // Changed to List
//
//   ParentsAddChildren({
//     this.id,
//     this.parentId,
//     this.numberOfChildren,
//     this.allChildrenAreInSameSchool,
//     this.classroomDelivery,
//     this.childId,
//     this.childName,
//     this.childSchoolID,
//     this.childImageUrl,
//     this.schoolName,
//     this.cafeteriaName,
//     this.selectedMealMenuData,
//   });
//
//   factory ParentsAddChildren.fromJson(Map<String, dynamic> json) {
//     return ParentsAddChildren(
//       parentId: json['parentId'],
//       id: json['id'],
//       numberOfChildren: json['numberOfChildren'],
//       classroomDelivery: json['classroomDelivery'],
//       allChildrenAreInSameSchool: json['allChildrenAreInSameSchool'],
//       childId: json['childId'],
//       childName: json['childName'],
//       childSchoolID: json['childSchoolID'],
//       childImageUrl: json['childImageUrl'],
//       schoolName: json['schoolName'],
//       cafeteriaName: json['cafeteriaName'],
//       selectedMealMenuData: json['selectedMealMenuData'] != null
//           ? (json['selectedMealMenuData'] as List)
//           .map((meal) => ParentSelectedMeals.fromMap(meal))
//           .toList()
//           : [],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'parentId': parentId,
//       'id': id,
//       'numberOfChildren': numberOfChildren,
//       'classroomDelivery': classroomDelivery,
//       'allChildrenAreInSameSchool': allChildrenAreInSameSchool,
//       'childId': childId,
//       'childName': childName,
//       'childSchoolID': childSchoolID,
//       'childImageUrl': childImageUrl,
//       'schoolName': schoolName,
//       'cafeteriaName': cafeteriaName,
//       'selectedMealMenuData': selectedMealMenuData?.map((meal) => meal.toMap()).toList(),
//     };
//   }
// }
