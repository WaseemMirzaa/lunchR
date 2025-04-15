import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:get/get.dart';
import 'package:snacktag/app/routes/app_pages.dart';
import 'package:snacktag/services/Shared_preference/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeSettingsController extends GetxController {
  // Reactive variable for the selected index
  var selectedIndex = 0.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var isLoading = false.obs;  // Add loading state variable

  Future<void> logout() async {
    try {
      await _auth.signOut();
      removeUserId();
      Get.offAllNamed(Routes.SPLASH); // Navigate to the Splash Screen
    } catch (e) {
      Get.snackbar("Error", "Failed to log out. Please try again.");
    }
  }
  Future<void> removeUserId() async {
    UserPreferences preferences = UserPreferences();
    preferences.removeUserId();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userId');
  }
  // Method to update the selected index
  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  Future<void> deleteAccount() async {
    try {
      isLoading.value = true;  // Start loading
      final user = _auth.currentUser;
      if (user != null) {
        // Delete user's children data
        QuerySnapshot childrenDocs = await FirebaseFirestore.instance
            .collection('parentsChildren')
            .where('parentId', isEqualTo: user.uid)
            .get();
        
        for (var doc in childrenDocs.docs) {
          await doc.reference.delete();
        }

        // Delete user's wallet data
        QuerySnapshot walletDocs = await FirebaseFirestore.instance
            .collection('ParentWalletAmount')  // Corrected collection name
            .where('parentId', isEqualTo: user.uid)
            .get();
            
        for (var doc in walletDocs.docs) {
          await doc.reference.delete();
        }

        // Delete user data from Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .delete();

        // Clear local storage
        await removeUserId();
        
        // Delete the Firebase Auth account
        await user.delete();
        
        // Navigate to splash screen after successful deletion
        Get.offAllNamed(Routes.SPLASH);
      }
    } catch (e) {
      print("Delete account error: $e");  // Add error logging
      Get.snackbar(
        "Error", 
        "Failed to delete account. Please try again.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;  // Stop loading regardless of success/failure
    }
  }
}
