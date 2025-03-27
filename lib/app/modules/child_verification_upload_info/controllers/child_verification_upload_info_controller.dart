import 'package:get/get.dart';
import 'package:luncher/models/parents_models/add_children.dart';

class ChildVerificationUploadInfoController extends GetxController {
  var childrenList = <ParentsAddChildren>[].obs;
  var isLoading = false.obs;

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

  @override
  void onClose() {
    super.onClose();
  }
}
