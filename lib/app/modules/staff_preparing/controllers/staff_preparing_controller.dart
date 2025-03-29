import 'package:get/get.dart';
import 'package:luncher/app/modules/staff_history/controllers/staff_history_controller.dart';
import 'package:luncher/models/parents_models/add_children.dart';
import 'package:luncher/models/cefeteria_admin/staff_model.dart';
import 'package:luncher/models/user_model.dart';
import 'package:luncher/services/staff_services/staff_order_preparation_service.dart';
import 'package:luncher/services/Shared_preference/preferences.dart';

class StaffOrderPreparingController extends GetxController {
  final StaffOrderPreparationService _preparationService = StaffOrderPreparationService();
  final UserPreferences _preferences = UserPreferences();

  final RxList<ParentsAddChildren> preparingOrdersList = <ParentsAddChildren>[].obs;
  final RxBool isLoading = false.obs;
  final Rx<StaffModel?> staffData = Rx<StaffModel?>(null);
  final Rx<UserModel?> cafeteriaData = Rx<UserModel?>(null);
  final RxString cafeteriaName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeStaffData();
  }

  Future<void> _initializeStaffData() async {
    try {
      isLoading.value = true;

      // Fetch staff data from preferences
      StaffModel? staffModel = await _preferences.getStaffDataPreference();

      if (staffModel != null) {
        staffData.value = staffModel;

        // Fetch cafeteria data using staff's userId
        if (staffModel.userId != null) {
          try {
            UserModel? cafeteria = await _preparationService.getCafeteriaData(staffModel.userId!);
            if (cafeteria != null) {
              cafeteriaData.value = cafeteria;
              cafeteriaName.value = cafeteria.cafeteriaName ?? '';
              print("📱 Cafeteria Data loaded - Name: ${cafeteriaName.value}");

              // Only start listening to orders if we have a cafeteria name
              if (cafeteriaName.value.isNotEmpty) {
                _listenToOrders();
              } else {
                print("⚠️ No cafeteria name found in cafeteria data");
                Get.snackbar(
                  'Warning',
                  'Cafeteria name not found',
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            }
          } catch (e) {
            print("❌ Error fetching cafeteria data: $e");
            Get.snackbar(
              'Error',
              'Failed to load cafeteria information',
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        } else {
          print("⚠️ No userId found in staff data");
          Get.snackbar(
            'Warning',
            'Staff information incomplete',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        print("❌ No staff data found in preferences");
        Get.snackbar(
          'Error',
          'Staff data not found',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print("❌ Error initializing staff data: $e");
      Get.snackbar(
        'Error',
        'Failed to load staff data',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void _listenToOrders() {
    if (cafeteriaName.value.isEmpty) return;

    _preparationService.getOrdersInPreparation(cafeteriaName.value).listen(
      (orders) {
        preparingOrdersList.assignAll(orders);
        update(['staffOrderPreparingId']);
        print("📋 Updated orders list: ${orders.length} orders");
      },
      onError: (error) {
        print("❌ Error listening to orders: $error");
        Get.snackbar(
          'Error',
          'Failed to load orders',
          snackPosition: SnackPosition.TOP,
        );
      },
    );
  }

  Future<void> markAsDelivered(String orderId) async {
    isLoading.value = true;
    try {
      var order = preparingOrdersList.firstWhere(
        (order) => order.orderPrepId == orderId,
        orElse: () => ParentsAddChildren()
      );

      if (staffData.value?.staffName != order.orderBy) {
        Get.snackbar(
          'Warning',
          'Only ${order.orderBy} can delivered this order',
          snackPosition: SnackPosition.TOP,
        );
        return;
      }

      // Mark order as delivered
      bool success = await _preparationService.markOrderAsDelivered(
        orderId,
        staffData.value?.staffName ?? ''
      );

      if (success) {
        // Send notification to parent
        // await _preparationService.sendDeliveryNotification({
        //   'userId': order.parentId,
        //   'title': 'Order Delivered! 🎉',
        //   'message': 'Dear Parent, ${order.childName}\'s meal has been delivered. We hope they enjoy their lunch! If you have any feedback, please let us know.',
        //   'type': 'order_delivered',
        //   'isRead': false,
        //   'timestamp': DateTime.now().toIso8601String(),
        //   'data': {
        //     'orderId': orderId,
        //     'childName': order.childName,
        //     'deliveredBy': staffData.value?.staffName,
        //     'deliveryTime': DateTime.now().toIso8601String(),
        //     'cafeteriaName': cafeteriaName.value
        //   }
        // });

        Get.snackbar(
          'Success',
          'Order delivered Successfully',
          snackPosition: SnackPosition.TOP,
        );
        
        final historyController = Get.find<StaffHistoryController>();
        historyController.updateSelectedIndex(1);
      }
    } catch (e) {
      print("❌ Error marking order as delivered: $e");
      Get.snackbar(
        'Error',
        'Failed to update order status',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    isLoading.value = true;
    try {
      bool success = await _preparationService.updateOrderStatus(orderId, newStatus);
      if (success) {
        Get.snackbar(
          'Success',
          'Order status updated',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print("❌ Error updating order status: $e");
      Get.snackbar(
        'Error',
        'Failed to update order status',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    // Clean up if needed
    super.onClose();
  }
}
