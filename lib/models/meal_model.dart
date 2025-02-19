class MealModel {
  String? id;
  String? name;
  String? availability;
  String? price;
  String? imageUrl;

  MealModel({this.id, this.name, this.availability, this.price, this.imageUrl});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "availability": availability,
      "price": price,
      "imageUrl": imageUrl,
    };
  }

  factory MealModel.fromMap(String id, Map<String, dynamic> data) {
    return MealModel(
      id: id,
      name: data["name"] ?? "",
      availability: data["availability"] ?? "",
      price: data["price"] ?? "",
      imageUrl: data["imageUrl"] ?? "",
    );
  }
}
