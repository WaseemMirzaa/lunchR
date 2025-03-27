import 'package:get/get.dart';
import 'package:luncher/models/parents_models/add_children.dart';
import 'package:luncher/models/parents_models/parent_add_wallet_model.dart';
import 'package:luncher/services/staff_services/child_verification_wallet_service.dart';

class ChildVerificationUploadInfoController extends GetxController {
  final ChildVerificationWalletService _walletService = ChildVerificationWalletService();
  var childrenList = <ParentsAddChildren>[].obs;
  var isLoading = false.obs;
  final walletData = Rxn<ParentAddWalletModel>();

  @override
  void onInit() {
    super.onInit();
    
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
      // Start preparation process here
      // Add your preparation logic
      
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch wallet: $e');
    } finally {
      isLoading.value = false;
    }
  }
  @override
  void onClose() {
    super.onClose();
  }
}
