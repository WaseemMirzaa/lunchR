import 'package:flutter/material.dart';
import 'package:luncher/config/app_colors.dart';
import 'package:luncher/config/app_text_style.dart';
import 'package:luncher/widgets/custom_textfeild.dart';
import 'package:luncher/widgets/custom_textfield_without_suffix.dart';

class SchoolSelectorDialog extends StatelessWidget {
  const SchoolSelectorDialog({super.key});

  static Future<void> show(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => const SchoolSelectorDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.6, // Made dialog bigger
        padding: const EdgeInsets.all(24), // Increased padding
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              AppColors.gradientStartColor,
              AppColors.gradientEndColor,
            ],
          ),
          borderRadius: BorderRadius.circular(24), // Increased border radius
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFieldWidget(
              text: 'Search',
              textController: textController,
              path: 'assets/icon/search.png',
              isBGChangeColor: true,
              height: 40,
              isSuffixBG: true,
              onChanged: (value) {},
            ),
            const SizedBox(height: 32),
            Text(
              'No Results Found',
              style: AppTextStyles.MetropolisMedium.copyWith(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Please try again with a different keyword',
              textAlign: TextAlign.center,
              style: AppTextStyles.MetropolisRegular.copyWith(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
