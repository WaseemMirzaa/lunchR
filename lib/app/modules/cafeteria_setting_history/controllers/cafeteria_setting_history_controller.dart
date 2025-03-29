import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CafeteriaSettingHistoryController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    print("CafeteriaSettingHistoryController initialized");
    fetchHistoryData();
  }

  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
    update();
  }

  Future<void> fetchHistoryData() async {
    try {
      isLoading.value = true;
      // Add your fetch logic here
      
    } catch (e) {
      errorMessage.value = 'Error fetching history data: $e';
      print("❌ Error in fetchHistoryData: $e");
    } finally {
      isLoading.value = false;
      update(['cafeteriaHistoryId']);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}