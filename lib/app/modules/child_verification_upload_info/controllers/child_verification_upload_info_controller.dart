import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snacktag/app/modules/staff_history/controllers/staff_history_controller.dart';
import 'package:snacktag/app/modules/staff_landing_page/controllers/staff_landing_page_controller.dart';
import 'package:snacktag/app/routes/app_pages.dart';
import 'package:snacktag/models/cefeteria_admin/staff_model.dart';
import 'package:snacktag/models/parents_models/add_children.dart';
import 'package:snacktag/models/parents_models/parent_add_wallet_model.dart';
import 'package:snacktag/services/Shared_preference/preferences.dart';
import 'package:snacktag/services/staff_services/child_verification_wallet_service.dart';

class ChildVerificationUploadInfoController extends GetxController {
  final ChildVerificationWalletService _walletService = ChildVerificationWalletService();
  var childrenList = <ParentsAddChildren>[].obs;
  var isLoading = false.obs;
  final walletData = Rxn<ParentAddWalletModel>();
  late final StaffHistoryController historyController;
  final UserPreferences preferences = UserPreferences();
  StaffModel? staffModel;
  @override
  void onInit() {
    super.onInit();
    getStaffData();
    // Initialize StaffHistoryController if it doesn't exist

    if (!Get.isRegistered<StaffHistoryController>()) {
      Get.put(StaffHistoryController(), permanent: true); // Make it permanent here too
    }
    historyController = Get.find<StaffHistoryController>();

    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      var receivedList = Get.arguments['childrenList'] as List<ParentsAddChildren>;
      if (receivedList.isNotEmpty) {
        childrenList.assignAll(receivedList);
        print("Received children data: ${childrenList.length} children");
      } else {
        print("No children data received");
      }
    } else {
      print("No arguments received or invalid format");
    }
  }

  void getStaffData() async {
    staffModel = await preferences.getStaffDataPreference();
    print("staff name is ${staffModel?.staffName}");
  }

  Future<void> fetchChildParentWallet(String parentId) async {
    try {
      isLoading.value = true;

      // Get the parent ID from the selected child

      if (parentId.isEmpty) {
        Get.snackbar('Error', 'Parent ID not found');
        return;
      }
      print("parent id is bbb  $parentId");

      // Fetch the wallet data
      final wallet = await _walletService.fetchChildParentWallet(parentId);

      if (wallet == null) {
        Get.snackbar('Error', 'Parent wallet not found');
        return;
      }

      walletData.value = wallet;
      print("Query completed. Number of documents found: ${walletData.value!.amount}");
      checkWalletBalance();
      // Start preparation process here
      // Add your preparation logic
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch wallet: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkWalletBalance() async {
    if (walletData.value == null || childrenList.isEmpty) {
      print("No wallet data or children data available");
      return;
    }

    double walletAmount = walletData.value!.amount;
    double mealPrice = double.parse(childrenList.first.selectedMealMenuData!.first.mealPrice!);

    if (walletAmount < mealPrice) {
      await Get.dialog(
        AlertDialog(
          title: const Text('Insufficient Balance'),
          content: Text(
              'The parent\'s wallet balance (\$${walletAmount.toStringAsFixed(2)}) is less than the meal price (\$${mealPrice.toStringAsFixed(2)}).'),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      try {
        startPreparationOrder(childrenList.first);
        // First ensure the StaffLandingPageController exists and get its instance
        // if (!Get.isRegistered<StaffLandingPageController>()) {
        //   Get.put(StaffLandingPageController(), permanent: true);
        // }
        // final staffLandingPageController = Get.find<StaffLandingPageController>();

        // // Set the index before navigation
        // staffLandingPageController.selectedIndex.value = 1;
        // historyController.updateSelectedIndex(0);

        // // Navigate to landing page
        // await Get.offAllNamed(
        //   Routes.STAFF_LANDING_PAGE,
        //   arguments: {'initialIndex': 1}  // Pass the initial index as argument
        // );
      } catch (e) {
        print("Navigation error: $e");
      }
    }
  }

  // Future<void> sendLowBalanceNotification(String parentId, double walletAmount, double mealPrice) async {
  //   try {
  //     await FirebaseFirestore.instance.collection('notifications').add({
  //       'userId': parentId,
  //       'title': 'Low Wallet Balance Alert',
  //       'message': 'Dear Parent, your wallet balance (\$${walletAmount.toStringAsFixed(2)}) is insufficient for the meal order (\$${mealPrice.toStringAsFixed(2)}). Please recharge your wallet to ensure uninterrupted meal service for your child.',
  //       'type': 'low_balance',
  //       'isRead': false,
  //       'timestamp': FieldValue.serverTimestamp(),
  //       'data': {
  //         'currentBalance': walletAmount,
  //         'requiredAmount': mealPrice,
  //         'shortfall': (mealPrice - walletAmount).toStringAsFixed(2)
  //       }
  //     });

  //     print("Low balance notification sent to parent: $parentId");
  //   } catch (e) {
  //     print("Error sending notification: $e");
  //   }
  // }

  Future<void> startPreparationOrder(ParentsAddChildren child) async {
    try {
      isLoading.value = true;

      // Save the order preparation
      bool success = await _walletService.saveOrderPreparation(child,staffModel!.staffName!);

      if (success) {
        // Update the local list item
        int index = childrenList.indexWhere((element) => element.childId == child.childId);
        if (index != -1) {
          childrenList[index].startPreparation = true;
          childrenList.refresh();
        }

        Get.snackbar(
          'Success',
          'Order preparation started successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Ensure the StaffLandingPageController exists
        if (!Get.isRegistered<StaffLandingPageController>()) {
          Get.put(StaffLandingPageController(), permanent: true);
        }
        final staffLandingPageController = Get.find<StaffLandingPageController>();

        // Set the index before navigation
        staffLandingPageController.selectedIndex.value = 1;
        historyController.updateSelectedIndex(0);

        // Navigate to landing page
        await Get.offAllNamed(Routes.STAFF_LANDING_PAGE, arguments: {'initialIndex': 1});
      } else {
        Get.snackbar(
          'Error',
          'Failed to start order preparation',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("❌ Error in startPreparationOrder: $e");
      Get.snackbar(
        'Error',
        'An error occurred while starting the preparation',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
