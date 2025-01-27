import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luncher/app/routes/app_pages.dart';
import 'package:luncher/config/app_colors.dart';
import 'package:luncher/config/app_text_style.dart';
import 'package:luncher/widgets/custom_textfeild.dart';

class SchoolSelectorDialog extends StatefulWidget {
  const SchoolSelectorDialog({super.key});

  static Future<String?> show(BuildContext context) async {
    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) => const SchoolSelectorDialog(),
    );
  }

  @override
  State<SchoolSelectorDialog> createState() => _SchoolSelectorDialogState();
}

class _SchoolSelectorDialogState extends State<SchoolSelectorDialog> {
  final TextEditingController textController = TextEditingController();
  final List<String> schools = [
    'Cambridge International School',
    'St. Patrick\'s High School',
    'The American International Academy'
  ];
  List<String> filteredSchools = [];

  @override
  void initState() {
    super.initState();
    filteredSchools = List.from(schools);
    textController.addListener(() {
      filterSchools();
    });
  }

  void filterSchools() {
    setState(() {
      if (textController.text.isEmpty) {
        filteredSchools = List.from(schools);
      } else {
        filteredSchools = schools
            .where((school) => school
                .toLowerCase()
                .contains(textController.text.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.6,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              AppColors.gradientStartColor,
              AppColors.gradientEndColor,
            ],
          ),
          borderRadius: BorderRadius.circular(24),
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
              onChanged: (value) => filterSchools(),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: filteredSchools.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                    )
                  : ListView.builder(
                      itemCount: filteredSchools.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.CAFETERIA);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              filteredSchools[index],
                              style: AppTextStyles.MetropolisMedium.copyWith(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
