import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:luncher/app/routes/app_pages.dart';
import 'package:luncher/config/app_const.dart';

class SplashController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    checkUserStatus();
  }

  Future<void> checkUserStatus() async {
    await Future.delayed(const Duration(seconds: 3)); // Delay for splash screen

    final user = _auth.currentUser;
    if (user == null) {
      // No user logged in, navigate to selection screen
      Get.offNamed(Routes.SELECTION);
      return;
    }

    // Fetch user document from Firestore
    DocumentSnapshot<Map<String, dynamic>> userDoc = await _firestore
        .collection(CollectionKey.USER_COLLECTION)
        .doc(user.uid)
        .get();

    if (!userDoc.exists) {
      Get.offNamed(Routes.SELECTION);
      return;
    }

    final role = userDoc.data()?['role'] as String?;

    if (role == null) {
      Get.offNamed(Routes.SELECTION);
      return;
    }

    // Navigate based on user role
    switch (role) {
      case 'cafeteriaStaff':
        Get.offNamed(Routes.STAFF_LANDING_PAGE);
        break;
      case 'cafeteriaAdmin':
        Get.offNamed(Routes.CAFETERIA_LANDING_PAGE);
        break;
      case 'parents':
        Get.offNamed(Routes.LANDING_PAGE);
        break;
      default:
        Get.offNamed(Routes.SELECTION);
    }
  }
}
