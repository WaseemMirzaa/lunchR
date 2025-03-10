class ParentAddWalletModel {
  String? id;
  double amount;
  bool enableMonthlyReload;
  String parrentId;

  ParentAddWalletModel({
     this.id,
    required this.amount,
    required this.enableMonthlyReload,
    required this.parrentId,
  });

  // Convert to JSON for Firebase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'enableMonthlyReload': enableMonthlyReload,
      'parentId' : parrentId
    };
  }

  // Factory method to create an instance from Firebase
  factory ParentAddWalletModel.fromJson(String? id,Map<String, dynamic> json) {
    return ParentAddWalletModel(
      id: json['userId'],
      amount: json['amount'].toDouble(),
      enableMonthlyReload: json['enableMonthlyReload'] ?? false,
      parrentId: json['parentId'] ?? false,
    );
  }
}
