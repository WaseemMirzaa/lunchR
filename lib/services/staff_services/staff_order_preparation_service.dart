import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luncher/models/parents_models/add_children.dart';
import 'package:luncher/models/user_model.dart';

class StaffOrderPreparationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> getCafeteriaData(String cafeteriaId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await _firestore
          .collection("users")
          .doc(cafeteriaId)
          .get();

      if (!doc.exists) {
        print("⚠️ No cafeteria found with ID: $cafeteriaId");
        return null;
      }

      print("📍 Fetched cafeteria data: ${doc.data()}");
      return UserModel.fromJson(doc.data()!);
    } catch (e) {
      print("❌ Error fetching cafeteria data: $e");
      throw Exception("Failed to fetch cafeteria data: $e");
    }
  }
  // Stream to get real-time updates for orders in preparation
  Stream<List<ParentsAddChildren>> getOrdersInPreparation(String cafeteriaName) {
    return _firestore
        .collection('orderPreparation')
        .where('cafeteriaName', isEqualTo: cafeteriaName)
        .where('status', isEqualTo: 'in_preparation')
        .where('delivered', isEqualTo: false)
        .snapshots()
        .map((snapshot) {
          print("📦 Fetched ${snapshot.docs.length} orders in preparation");
          return snapshot.docs.map((doc) {
            print("Order Data: ${doc.data()}");
            return ParentsAddChildren.fromJson(doc.data());
          }).toList();
        });
  }
    // Stream to get real-time updates for orders in preparation
  Stream<List<ParentsAddChildren>> getDeliveredOrder(String cafeteriaName) {
    return _firestore
        .collection('orderPreparation')
        .where('cafeteriaName', isEqualTo: cafeteriaName)
        .where('status', isEqualTo: 'Delivered')
        .where('delivered', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
          print("📦 Fetched ${snapshot.docs.length} Delivered orders");
          return snapshot.docs.map((doc) {
            print("Order Data: ${doc.data()}");
            return ParentsAddChildren.fromJson(doc.data());
          }).toList();
        });
  }

  // Method to update order status
  Future<bool> updateOrderStatus(String orderId, String newStatus) async {
    try {
      await _firestore.collection('orderPreparation').doc(orderId).update({
        'status': newStatus,
        'lastUpdated':DateTime.now().toIso8601String(),
      });
      print("✅ Order status updated successfully: $orderId -> $newStatus");
      return true;
    } catch (e) {
      print("❌ Error updating order status: $e");
      return false;
    }
  }

  // Method to mark order as delivered
  Future<bool> markOrderAsDelivered(String orderId) async {
    try {
      await _firestore.collection('orderPreparation').doc(orderId).update({
        'delivered': true,
        'status': 'delivered',
        'orderDeliveredTime': DateTime.now().toIso8601String(),
        'startPreparation':false,
      });
      print("✅ Order marked as delivered: $orderId");
      return true;
    } catch (e) {
      print("❌ Error marking order as delivered: $e");
      return false;
    }
  }

  // Method to get specific order details
  Future<ParentsAddChildren?> getOrderDetails(String orderId) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('orderPreparation')
          .doc(orderId)
          .get();

      if (!doc.exists) {
        print("⚠️ Order not found: $orderId");
        return null;
      }

      return ParentsAddChildren.fromJson(doc.data() as Map<String, dynamic>);
    } catch (e) {
      print("❌ Error fetching order details: $e");
      return null;
    }
  }
}