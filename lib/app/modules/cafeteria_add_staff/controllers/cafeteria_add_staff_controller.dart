import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luncher/app/routes/app_pages.dart';
import 'package:luncher/config/validation.dart';
import 'package:luncher/models/cefeteria_admin/staff_model.dart';
import 'package:luncher/services/Shared_preference/preferences.dart';
import 'package:luncher/services/cefeteria_admin_services/add_staff_service.dart';

class CafeteriaAddStaffController extends GetxController {
  final AddStaffService _addStaffService = AddStaffService();
  //TODO: Implement CafeteriaAddStaffController
  var nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  RxBool isLoading = false.obs;
  StaffModel? staffData;
  Rx<File?> selectedImage = Rx<File?>(null);
  RxString imageUrl = ''.obs;
  final UserPreferences userPreferences = UserPreferences();
// ------  update and delete the staff data
  var staffDataList = <StaffModel>[].obs;
  // --------------- end update delete data
  String staffName = '';

  @override
  void onInit() {
    fetchStaffData();

    super.onInit();
    print("object");
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      imageUrl.value = ''; // Clear the old network image when new one is picked
    }
  }

  // Function to handle form submission and save data
  Future<void> addStaffData() async {
    var userId = await userPreferences.getUserId();
    // Generate a unique staffId using UUID
    // String staffId = const Uuid().v4(); // Generates a unique v4 UUID


    // Replace with actual user ID from authentication
    String staffName = nameController.text.trim();
    String staffEmail = emailController.text.trim();
    String staffPhone = phoneController.text.trim();
    String staffPassword = passwordController.text.trim();

    // Validate input data before saving
    if (staffName.isEmpty || staffEmail.isEmpty || staffPhone.isEmpty || staffPassword.isEmpty) {
      Get.snackbar("Validation Error", "All fields are required");

      return;
    }
    if (!(Validator.isValidEmail(staffEmail))) {
      Get.snackbar("Validation Error", "Please Enter Valid Email");
      return;
    }
    isLoading.value = true;
    try {
      if (staffData == null) {
        // create new model
        print("user id staff screen is ${userId}");
        // Check if phone number exists
        bool phoneExists = await _addStaffService.isPhoneNumberExists(phoneController.text);
        print("object bool $phoneExists");
        if (phoneExists) {
          Get.snackbar("Phone Number Exists", "This phone number is already registered.",
             );
          isLoading.value = false;
          return;
        }

        StaffModel newModel = StaffModel(
          staffPassword: staffPassword,
          staffEmail: staffEmail,
          staffName: staffName,
          staffPhone: staffPhone,
          userId: userId,
        );
        // Call the service method to save data to Firestore
        await _addStaffService.addStaff(newModel, selectedImage.value,userId!).then((result) {
          Get.back();
          Get.offNamed(Routes.CAFETERIA_STAFF_LIST);

          nameController.text = '';
          emailController.text = '';
          phoneController.text = '';
          passwordController.text = '';
          selectedImage.value = null;
          imageUrl.value = '';
        });
      }
      //for updating staff data
      else {}

      // Optional: Show success message using GetX
      Get.snackbar('Success', 'Staff data saved successfully');
    } on SocketException catch (e) {
      // Handle network-related errors (e.g., DNS lookup failure, no internet)
      Get.snackbar("Network Error", "Unable to reach the server. Please check your internet connection.");
      print("SocketException: ${e.message}");
    } on FirebaseException catch (e) {
      // Handle Firebase-specific errors (e.g., issues with Firebase database)
      Get.snackbar("Firebase Error", "An error occurred while connecting to Firebase: ${e.message}");
      print("FirebaseException: ${e.message}");
    }catch (e) {
      // Handle errors (e.g., validation, Firebase errors)
      Get.snackbar("Error", "Failed to save Staff. Please try again.");
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // fetch the staff data
  void fetchStaffData() async {
    var userId = await userPreferences.getUserId();

    isLoading.value = true;
    // bind the stream to the staff list
    staffDataList.bindStream(_addStaffService.fetchStaffData(userId!));
    // listen to the stream and set loading false once data received
    // _addStaffService.fetchStaffData(userId).listen((snapShot) {
    //   if (snapShot.isNotEmpty) {
    //     isLoading.value = false; // Set loading to false when data is received
    //   }
    //   isLoading.value = false; // Set loading to false when data is received
    // });
    isLoading.value = false; // Set loading to false when data is received
  }

  void deleteStaffData(String staffId) async {
    await _addStaffService.deleteStaffData(staffId);
    fetchStaffData();
  }


}
