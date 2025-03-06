import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luncher/services/parents/parenents_services.dart';
import 'package:luncher/widgets/custom_snackbar.dart';

class ParentsProfileController extends GetxController {

  TextEditingController parentNameController = TextEditingController();

  RxString imageUrl = ''.obs;
  RxBool isLoading = false.obs;

  Rx<File?> selectedImage = Rx<File?>(null);

  Future<void> validateAndContinue() async {

    if(validate()){

      isLoading.value = true;

      var parentN = parentNameController.text;

      final FirebaseAuth auth = FirebaseAuth.instance;
      String? userId = auth.currentUser?.uid;

      if (selectedImage.value != null && userId != null) {


        imageUrl.value = await uploadImage(selectedImage.value!, "cafeteria_details", userId);

        print('Uploaded Image Url  🔴🔴🔴🔴🔴🔴${imageUrl.value}');

        ParentsServices().addParentsInfo(parentN, imageUrl.value);

      }

    }

  }

  Future<String> uploadImage(
      File imageFile, String folderName, String docId) async {
    try {
      final FirebaseStorage _storage = FirebaseStorage.instance;
      Reference ref = _storage.ref().child('$folderName/$docId.jpg');
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print('Error Uploading Image 🔴🔴🔴🔴🔴🔴$e');
      throw Exception("Image upload failed: $e");
    }
  }

  bool validate() {

    var parentName = parentNameController.text;

    if(selectedImage.value == null) {

      showCustomSnack('Cafeteria photo is required.');

      return false;
    }
    if(parentName.isEmpty) {

      showCustomSnack('All fields are required.');

      return false;
    }

    return true;

  }
}
