import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luncher/app/modules/staff_history/controllers/staff_history_controller.dart';
import 'package:luncher/app/modules/staff_landing_page/controllers/staff_landing_page_controller.dart';
import 'package:luncher/app/routes/app_pages.dart';
import 'package:luncher/models/parents_models/add_children.dart';
import 'package:luncher/models/parents_models/parent_add_wallet_model.dart';
import 'package:luncher/services/staff_services/child_verification_wallet_service.dart';

class ChildVerificationUploadInfoController extends GetxController {
  final ChildVerificationWalletService _walletService = ChildVerificationWalletService();
  var childrenList = <ParentsAddChildren>[].obs;
  var isLoading = false.obs;
  final walletData = Rxn<ParentAddWalletModel>();
  late final StaffHistoryController historyController;

  @override
  void onInit() {
    super.onInit();
    // Initialize StaffHistoryController if it doesn't exist
    if (!Get.isRegistered<StaffHistoryController>()) {
      Get.put(StaffHistoryController(), permanent: true);  // Make it permanent here too
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
        // First ensure the StaffLandingPageController exists and get its instance
        if (!Get.isRegistered<StaffLandingPageController>()) {
          Get.put(StaffLandingPageController(), permanent: true);
        }
        final staffLandingPageController = Get.find<StaffLandingPageController>();
        
        // Set the index before navigation
        staffLandingPageController.selectedIndex.value = 1;
        historyController.updateSelectedIndex(0);
        
        // Navigate to landing page
        await Get.offAllNamed(
          Routes.STAFF_LANDING_PAGE,
          arguments: {'initialIndex': 1}  // Pass the initial index as argument
        );
        
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
  @override
  void onClose() {
    super.onClose();
  }
}
