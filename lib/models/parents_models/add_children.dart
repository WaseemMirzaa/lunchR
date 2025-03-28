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
  String? date;
  String? orderPreparationDate;
  String? status;  // Added status field
  
  bool startPreparation;
  bool delivered;

  List<ParentSelectedMeals>? selectedMealMenuData;

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
    this.date,
    this.orderPreparationDate,
    this.status,  // Added to constructor
    this.startPreparation = false,
    this.delivered = false,
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
      date: json['date'],
      orderPreparationDate: json['orderPreparationDate'],
      status: json['status'],  // Added to fromJson
      startPreparation: json['startPreparation'] ?? false,
      delivered: json['delivered'] ?? false,
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
      'date': date ?? DateTime.now().toIso8601String(),
      'orderPreparationDate': orderPreparationDate,
      'status': status,  // Added to toJson
      'startPreparation': startPreparation,
      'delivered': delivered,
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
