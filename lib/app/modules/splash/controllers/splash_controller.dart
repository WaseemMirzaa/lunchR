import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:luncher/app/routes/app_pages.dart';
import 'package:luncher/config/app_const.dart';
import 'package:luncher/models/cefeteria_admin/staff_model.dart';
import 'package:luncher/services/Shared_preference/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserPreferences preferences = UserPreferences();
  @override
  void onInit() {
    super.onInit();
    checkUserStatus();
  }

  Future<void> checkUserStatus() async {
    StaffModel? staffModel = await preferences.getStaffDataPreference();

    await Future.delayed(const Duration(seconds: 3)); // Delay for splash screen

    final user = _auth.currentUser;
    print("user value is on splash ${user?.phoneNumber}");
    if (user == null) {
      // No user logged in, navigate to selection screen
      // CHECK THE STAFF IS LOGED IN OR NOT
      if (staffModel != null) {
        Get.offAllNamed(Routes.STAFF_LANDING_PAGE);
        return;
      }
      Get.offNamed(Routes.SELECTION);
      return;
    }

    // Fetch user document from Firestore
    DocumentSnapshot<Map<String, dynamic>> userDoc =
        await _firestore.collection(CollectionKey.USER_COLLECTION).doc(user.uid).get();
    print("user value documents splash ${userDoc.exists}");

    if (!userDoc.exists) {
      Get.offNamed(Routes.SELECTION);
      return;
    }

    final role = userDoc.data()?['role'] as String?;

    // // CHECK THE PARENTS PROFILE COMPLETED OR NOT
    // if (userDoc.data() != null && userDoc.data()!.containsKey('parentsName') && role == "parents") {
    //  return Get.offNamed(Routes.PARENT_PROFILE);
    // }




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
