import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luncher/models/cefeteria_admin/staff_model.dart';
import 'package:luncher/services/base_service.dart';

class AddStaffService extends BaseService {
  Future<void> addStaff(StaffModel staff, File? imageFile,String userId) async {
    String docId = FirebaseFirestore.instance
        .collection("users").doc(userId).collection("staffData")
        .doc()
        .id; // Assign the generated ID to the meal model
// Assign the generated ID to the meal model
    staff.id = docId;
    // Upload image if available
    if (imageFile != null) {
      staff.imageUrl = await uploadImage(imageFile, "staffProfile", docId);
    }
    // Save Staff Data to Firestore
    await createDocument("staffData", docId, staff.toMap());
  }
// Fetch the staff Data
  Stream<List<StaffModel>> fetchStaffData(String userId) {

    return FirebaseFirestore.instance
        .collection("staffData")
        .where("userId", isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        print("sss#ll ${doc.data()}");
        return StaffModel.fromMap(doc.id, doc.data());
      }).toList();
    });
  }
  // Delete the Staff Data
Future<void> deleteStaffData(String staffId)async{
    await deleteDocument("staffData", staffId);
    // await deleteStorage("staffData", staffId);
}

  // Check if phone number already exists
  Future<bool> isPhoneNumberExists(String phoneNumber) async {
    return await isDocumentExists("staffData", "staffPhone", phoneNumber);
  }
Future<void> editStaffData(String userId,String staffId,Map<String, dynamic> data)async{
    await editDocuments("staffData", staffId, userId,data);
}
  /// ✅ Update staff data with user verification
  Future<bool> updateStaff(String staffId, String userId, StaffModel updatedStaff,Map<String, dynamic> data) async {
    try {
      // await editDocuments(
      //   "staffData", // Collection name
      //   staffId, // Document ID
      //   userId,  // User ID for verification
      //   updatedStaff.toMap(), // Data to update
      // );
     await editStaffDocuments(staffId, userId, "staffData" ,data);
      return true;
    } catch (e) {
      print("❌ Error updating staff: $e");
      return false;
    }
  }
}
