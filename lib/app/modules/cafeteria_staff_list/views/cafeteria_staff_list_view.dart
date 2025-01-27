import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luncher/app/modules/cafeteria_home_settings/controllers/cafeteria_home_settings_controller.dart';
import 'package:luncher/config/app_text_style.dart';
import 'package:luncher/widgets/reuse_button.dart';

class CafeteriaStaffListView extends StatelessWidget {
  const CafeteriaStaffListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CafeteriaHomeSettingsController>();
    final List<String> staffMembers = [
      'Sandra Vargas',
      'Matthew Murphy',
      'Emma',
      'Sara Mendez',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        controller.updateSelectedIndex(0);
                      },
                      child: Container(
                        height: 35,
                        width: 35,
                        margin: const EdgeInsets.only(top: 16),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 4,
                              spreadRadius: 2,
                            ),
                          ],
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Image.asset(
                            "assets/icon/back.png",
                            height: 15,
                            width: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Staff Members',
                      style: AppTextStyles.MetropolisBold.copyWith(
                        color: const Color(0xFF434343),
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: staffMembers.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 39,
                                  height: 39,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.white, width: 3),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 6,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: const CircleAvatar(
                                    radius: 30,
                                    backgroundImage: AssetImage(
                                        'assets/images/icecream.png'), // Replace with your image asset
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  staffMembers[index],
                                  style:
                                      AppTextStyles.MetropolisMedium.copyWith(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // Edit action here
                                    controller.updateSelectedIndex(4);
                                  },
                                  child: Text(
                                    'Edit',
                                    style: AppTextStyles.MetropolisRegular
                                        .copyWith(
                                      fontSize: 12,
                                      color: const Color(0xFFFF9A0D),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                GestureDetector(
                                  onTap: () {
                                    // Delete action here
                                  },
                                  child: Image.asset(
                                    'assets/icon/delete.png',
                                    width: 15,
                                    height: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            CustomButton(
              text: 'Add',
              onPressed: () {
                // Add button action here
              },
              isLoading: false.obs,
            ),
          ],
        ),
      ),
    );
  }
}
