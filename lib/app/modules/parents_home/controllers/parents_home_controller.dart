import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luncher/models/parents_models/add_children.dart';
import 'package:luncher/models/parents_models/parent_add_wallet_model.dart';
import 'package:luncher/services/parents/parent_home_service.dart';

class ParentsHomeController extends GetxController {
  final ParentHomeService parentHomeService = ParentHomeService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //TODO: Implement ParentsHomeController

  final count = 0.obs;
  // FETCHING CHILDREN DATA AGAINST PARENTS
  var childrenList = <ParentsAddChildren>[].obs;
  var parentAddWalletModel = Rxn<ParentAddWalletModel>(); // Observable wallet model
  var isLoading = false.obs;
  final switchController = ValueNotifier<bool>(false);
  @override
  void onInit() {
    listenToWalletChanges(); // Start listening for real-time updates
    fetchChildren();

    super.onInit();
  }

  // Listen for real-time wallet data updates
  void listenToWalletChanges() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      print("❌ No logged-in user found.");
      return;
    }

    print("🚀 Listening for wallet updates for Parent ID: ${currentUser.uid}");

    parentHomeService.fetchWalletStreamByParentId(currentUser.uid).listen(
          (wallet) {
        parentAddWalletModel.value = wallet;
        if (wallet != null) {
          switchController.value = wallet.enableMonthlyReload; // Sync switch state
        }
        print("🔄 Wallet data updated: ${wallet?.toJson()}");
      },
      onError: (error) {
        print("❌ Error fetching wallet data: $error");
      },
    );
  }

  // Toggle monthly reload switch in Firestore
  Future<void> toggleMonthlyReload(bool newValue) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null || parentAddWalletModel.value == null) return;

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .collection('ParentWalletAmount')
          .doc(parentAddWalletModel.value!.id)
          .update({'enableMonthlyReload': newValue});

      print("✅ Monthly reload updated to: $newValue");
    } catch (e) {
      print("❌ Error updating monthly reload: $e");
    }
  }

  // FETCH CHILDREN DATA AGAINST PARENTS
  Future<void> fetchChildren() async {
    isLoading.value = true;
    final currentParentChildren = FirebaseAuth.instance.currentUser;
    var allChilSameSchool = [];
    if (currentParentChildren != null) {
      List<ParentsAddChildren> children =
          await parentHomeService.fetchChildrenByParentId(currentParentChildren.uid);
      childrenList.assignAll(children);
      print("children data is  $currentParentChildren");
    }
    print("children data is empty $currentParentChildren");

    isLoading.value = false;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
