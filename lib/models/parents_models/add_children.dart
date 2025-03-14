import 'package:luncher/models/parents_models/parent_selected_meals.dart';

class ParentsAddChildren {
  final String? id;
  final String? parentId;
  final String? numberOfChildren;
  final String? allChildrenAreInSameSchool;
  final String? classroomDelivery;

  final String? childId;
  final String? childName;
  final String? childSchoolID;
  final String? childImageUrl;

  final String? schoolName;
  final String? cafeteriaName;

  final List<ParentSelectedMeals>? selectedMealMenuData; // Changed to List

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
      'selectedMealMenuData': selectedMealMenuData?.map((meal) => meal.toMap()).toList(),
    };
  }
}
