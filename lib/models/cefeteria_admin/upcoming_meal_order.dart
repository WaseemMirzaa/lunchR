class UpcomingMealOrder {
  final String? image;
  final String? itemName;
  final String? weekday;
  final int? expectedStudent;

  UpcomingMealOrder({
     this.image,
     this.itemName,
     this.weekday,
     this.expectedStudent,
  });

  Map<String, dynamic> toJson() {
    return {
      "image": image,
      "itemName": itemName,
      "weekday": weekday,
      "expectedStudent": expectedStudent,
    };
  }
}