class MealSheduleModel {
  String mealId;
  String userId;
  String? sheduleId;
  List<String> availableAt;
  List<String> repeatOn;

  MealSheduleModel({
    required this.mealId,
    required this.userId,
    this.sheduleId,
    required this.availableAt,
    required this.repeatOn,
  });

  /// Convert ScheduleSelection object to a Map
  Map<String, dynamic> toMap() {
    return {
      'mealId': mealId,
      'userId': userId,
      'sheduleId': sheduleId,
      'availableAt': availableAt,

      'repeatOn': repeatOn,
    };
  }

  /// Create a ScheduleSelection object from a Map
  factory MealSheduleModel.fromMap(Map<String, dynamic> map) {
    return MealSheduleModel(
      mealId: map['mealId'] ?? '',
      userId: map['userId'] ?? '',
      sheduleId: map['sheduleId'] ?? '',
      availableAt: List<String>.from(map['availableAt'] ?? []),
      repeatOn: List<String>.from(map['repeatOn'] ?? []),
    );
  }

  /// Convert the object to a formatted string
  @override
  String toString() {
    return 'Meal ID: $mealId | User ID: $userId | Available at: ${availableAt.join(", ")} | Repeat on: ${repeatOn.join(", ")}';
  }
}
