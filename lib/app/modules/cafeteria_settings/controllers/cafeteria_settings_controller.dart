import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:luncher/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CafeteriaSettingsController extends GetxController {
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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userId');
  }
}
