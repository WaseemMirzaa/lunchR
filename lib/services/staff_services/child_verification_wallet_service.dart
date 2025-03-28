import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luncher/models/parents_models/add_children.dart';
import 'package:luncher/models/parents_models/parent_add_wallet_model.dart';
import 'package:luncher/services/base_service.dart';

class ChildVerificationWalletService extends BaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<ParentAddWalletModel?> fetchChildParentWallet(String parentId) async {
    try {
      // Get the parent's wallet document
      final walletSnapshot = await _firestore
          .collection('users')
          .doc(parentId)
          .collection('ParentWalletAmount')
          .limit(1) // Get the first document in the collection
          .get();

      if (walletSnapshot.docs.isEmpty) {
        print("No wallet found for parent: $parentId");
        return null;
      }

      DocumentSnapshot firstDoc = walletSnapshot.docs.first;
      return ParentAddWalletModel.fromJson(
        firstDoc.id,
        firstDoc.data() as Map<String, dynamic>,
      );
    } catch (e) {
      print("Error fetching parent wallet: $e");
      throw Exception("Failed to fetch parent wallet: $e");
    }
  }

  Future<bool> saveOrderPreparation(ParentsAddChildren childData) async {
    try {
      // Create new document in orderPreparation collection
      DocumentReference orderPrepRef = _firestore.collection('orderPreparation').doc();

      Map<String, dynamic> orderPrepData = {
        'orderPrepId': orderPrepRef.id,
        'childId': childData.childId,
        'parentId': childData.parentId,
        'childName': childData.childName,
        'schoolName': childData.schoolName,
        'cafeteriaName': childData.cafeteriaName,
        'selectedMeals': childData.selectedMealMenuData?.map((meal) => meal.toMap()).toList(),
        'startPreparation': true,
        'delivered': false,
        'preparationStartTime': DateTime.now().toIso8601String(),
        'date': childData.date,
        'status': 'in_preparation'
      };

      print("📝 Saving Order Preparation Data:");
      print(orderPrepData);

      await orderPrepRef.set(orderPrepData);
      print("✅ Order preparation document created with ID: ${orderPrepRef.id}");

      return true;
    } catch (e) {
      print("❌ Error saving order preparation: $e");
      return false;
    }
  }
}
