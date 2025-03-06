import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:luncher/app/routes/app_pages.dart';
import 'package:luncher/services/Shared_preference/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeSettingsController extends GetxController {
  // Reactive variable for the selected index
  var selectedIndex = 0.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
}
