import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:luncher/app/routes/app_pages.dart';
import 'package:luncher/models/parents_models/parent_add_wallet_model.dart';
import 'package:luncher/services/Shared_preference/preferences.dart';
import 'package:luncher/services/parents/parent_add_wallet_service.dart';

class ParentsAddWalletController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Checkbox state
  var isMonthlyReloadEnabled = false.obs;
  RxBool isLoading = false.obs;
// final UserPreferences _pref = UserPreferences();
  // Selected index for peso options
  var selectedIndex = (-1).obs; // -1 means no peso is selected

  // Amount entered
  var amount = ''.obs;
  @override
  void onInit() {
    super.onInit();
  }

  // Updates the amount based on peso selection
  void selectPeso(int index, int peso) {
    selectedIndex.value = index;
    amount.value = peso.toString();
  }

  // Save wallet data to Firebase
  Future<void> saveWalletData() async {
    final user = _auth.currentUser;
    print("current User id is ${user!.uid}");
    if (amount.value.isEmpty) {
      Get.snackbar("Error", "Please enter an amount");
      isLoading.value = false;

      return;
    }

    double parsedAmount = double.tryParse(amount.value) ?? 0;
    if (parsedAmount <= 0) {
      Get.snackbar("Error", "Enter a valid amount");
      isLoading.value = false;
      return;
    }

    ParentAddWalletModel wallet = ParentAddWalletModel(
      parrentId: user.uid,
      amount: parsedAmount,
      enableMonthlyReload: isMonthlyReloadEnabled.value,
    );
    isLoading.value = true;

    await ParentAddWalletService().addOrUpdateWalletAmount(wallet).then((val) {
      Get.snackbar("Success", "Data saved Successfully");
      Get.toNamed(Routes.PARENTS_CHILDREN_DETAILS);
      isLoading.value = false;
    }).catchError((error) {
      print("Add Amount to wallet ${error.toString()}");
    });
    isLoading.value = false;
  }

  // Clears peso selection when the user types manually
  void clearSelectionOnTyping(String value) {
    if (value.isNotEmpty) {
      selectedIndex.value = -1;
    }
    amount.value = value;
  }
}
