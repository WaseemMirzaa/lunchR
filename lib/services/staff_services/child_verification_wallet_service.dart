import 'package:cloud_firestore/cloud_firestore.dart';
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
          .limit(1)  // Get the first document in the collection
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
}
