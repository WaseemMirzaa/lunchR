import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luncher/models/parents_models/parent_add_wallet_model.dart';
import 'package:luncher/services/base_service.dart';

class ParentAddWalletService extends BaseService {

  Future<void> addOrUpdateWalletAmount(ParentAddWalletModel model) async {
    try {
      // Reference to the user's wallet document
      DocumentReference userWalletRef = FirebaseFirestore.instance
          .collection("users")
          .doc(model.parrentId) // Unique wallet per user
          .collection("ParentWalletAmount")
          .doc(model.parrentId); // Use userId as document ID to make it unique per user

      DocumentSnapshot walletSnapshot = await userWalletRef.get();

      if (walletSnapshot.exists) {
        // Wallet exists, update the amount
        double existingAmount = (walletSnapshot.data() as Map<String, dynamic>)['amount'] ?? 0.0;
        double newTotalAmount = existingAmount + model.amount;

        await userWalletRef.update({
          'amount': newTotalAmount,
          'enableMonthlyReload': model.enableMonthlyReload, // Update boolean
          'updatedAt': FieldValue.serverTimestamp(), // Store last update time
        });

        print("✅ Wallet amount updated successfully for user: ${model.parrentId}");
      } else {
        // Wallet doesn't exist, create a new one for the user
        model.id = userWalletRef.id;
        await userWalletRef.set({
          'id': model.id,
          'userId': model.parrentId,
          'amount': model.amount, // Set initial amount
          'enableMonthlyReload': model.enableMonthlyReload,
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        });

        print("✅ New wallet created for user: ${model.parrentId}");
      }
    } catch (e) {
      print("❌ Error updating wallet amount for user ${model.parrentId}: $e");
    }
  }



}
