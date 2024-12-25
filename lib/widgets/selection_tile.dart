import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luncher/app/routes/app_pages.dart';
import 'package:luncher/config/app_text_style.dart';

class SelectionTile extends StatelessWidget {
  final String imgPath;
  final String text;
  final double imageHeight; // Optional image height
  final double imageWidth; // Optional image width
  final bool isParent;

  // Constructor with optional parameters for image height and width
  const SelectionTile({
    required this.imgPath,
    required this.text,
    this.isParent = false,
    this.imageHeight = 102, // Default value if not passed
    this.imageWidth = 102, // Default value if not passed
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isParent
            ? Get.toNamed(Routes.PHONE_AUTHENTICATION)
            : Get.toNamed(Routes.CAFETERIA_PHONE_AUTHENICATION);
      },
      child: Container(
        height: 182, // Fixed height for the container
        width: 136, // Fixed width for the container
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(14)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6,
              offset: Offset(0, 3), // Position of the shadow
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center, // Align the content in the center
          children: [
            // Image inside the container, scaled to fit while maintaining aspect ratio
            Image.asset(
              imgPath,
              height: imageHeight, // Use the provided image height
              width: imageWidth, // Use the provided image width
              fit: BoxFit
                  .contain, // Ensures the image scales and stays within the bounds
            ),
            // Text below the image, positioned relative to the stack
            Positioned(
              bottom: 10, // Adjust the vertical position of the text
              child: Text(
                text,
                style: AppTextStyles.MetropolisBold.copyWith(
                  fontSize: 22, // Adjust font size as needed
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
