import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:luncher/config/app_text_style.dart';
import 'package:luncher/widgets/custom_wallet_widget.dart';
import 'package:luncher/widgets/reuse_button.dart';

import '../controllers/cafeteria_history_details_controller.dart';
class CafeteriaHistoryDetailsView extends GetView<CafeteriaHistoryDetailsController> {
  const CafeteriaHistoryDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    // Title
                    Center(
                      child: Text(
                        'History',
                        style: AppTextStyles.MetropolisMedium.copyWith(
                          fontSize: 18,
                          color: const Color(0xFF434343),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Month and Year
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'July ',
                              style: AppTextStyles.RobotoLight.copyWith(
                                fontSize: 18,
                                color: const Color(0xFF2E2E2E),
                              ),
                            ),
                            TextSpan(
                              text: '2024',
                              style: AppTextStyles.RobotoBold.copyWith(
                                fontSize: 18,
                                color: const Color(0xFF2E2E2E),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // List of Orders
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount:  2,
                      separatorBuilder: (context, index) {
                        return Divider(
                          thickness: 1, // Line thickness
                          color: Colors.grey[300], // Line color
                        );
                      },                  itemBuilder: (context, index) {
                      return Container(
                        height:  80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: const Offset(0, 6), // changes position of shadow
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Row(
                          children: [
                            // Profile image wrapped with Container
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start, // Align image to top
                              children: [
                                Container(
                                  width: 55,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white, width: 3),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 6,
                                        offset: const Offset(0, 3), // shadow position
                                      ),
                                    ],
                                  ),
                                  child:  ClipOval(
                                    child: Image.asset(
                                      'assets/images/profile_emoji.png',
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 12),

                            // Details Column
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Abc",
                                        style: AppTextStyles.MetropolisMedium.copyWith(
                                          fontSize: 14,
                                        ),
                                      ),
                                      // const Spacer(),
                                      // if (isEdit)
                                      //   GestureDetector(
                                      //     onTap: () {
                                      //       Get.toNamed(Routes.CAFETERIA);
                                      //     },
                                      //     child: Text(
                                      //       "Edit",
                                      //       style: AppTextStyles.MetropolisRegular.copyWith(
                                      //         fontSize: 12,
                                      //         color: const Color(0xFFFF9A0D),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // const SizedBox(width: 8),
                                      // // if (!isShowScan)
                                      //   GestureDetector(
                                      //     onTap: () {
                                      //       // final homeController = Get.find<ParentsAddWalletController>();
                                      //       // ParentsHomeController().deleteChildrenById(childList!.parentId!,childList!.childId!);
                                      //     },
                                      //     child: Image.asset(
                                      //       'assets/icon/delete.png',
                                      //       width: 15,
                                      //       height: 15,
                                      //     ),
                                      //   )
                                    ],
                                  ),
                                  Text(
                                    "school name",
                                    style: AppTextStyles.MetropolisRegular.copyWith(
                                        fontSize: 12, color: const Color(0xFF858585)),
                                  ),
                                  Text(
                                    "child id ",
                                    style: AppTextStyles.MetropolisRegular.copyWith(
                                        fontSize: 12, color: const Color(0xFF858585)),
                                  ),
                                  // if (isType)
                                  //   Row(
                                  //     children: [
                                  //       Text(
                                  //         "Type: ",
                                  //         style: AppTextStyles.MetropolisRegular.copyWith(
                                  //             fontSize: 12, color: Colors.black),
                                  //       ),
                                  //       Text(
                                  //         "Wallet Balance",
                                  //         style: AppTextStyles.MetropolisRegular.copyWith(
                                  //             fontSize: 12, color: const Color(0xFF858585)),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // if (isDuration)
                                  //   Row(
                                  //     children: [
                                  //       Text(
                                  //         "Duration: ",
                                  //         style: AppTextStyles.MetropolisRegular.copyWith(
                                  //             fontSize: 12, color: Colors.black),
                                  //       ),
                                  //       Text(
                                  //         "Weekly",
                                  //         style: AppTextStyles.MetropolisRegular.copyWith(
                                  //             fontSize: 12, color: const Color(0xFF858585)),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // if (isStaff)
                                  //   Row(
                                  //     children: [
                                  //       Text(
                                  //         "Staff Name: ",
                                  //         style: AppTextStyles.MetropolisRegular.copyWith(
                                  //             fontSize: 12, color: Colors.black),
                                  //       ),
                                  //       Text(
                                  //         "Name",
                                  //         style: AppTextStyles.MetropolisRegular.copyWith(
                                  //             fontSize: 12, color: const Color(0xFF858585)),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // if (isDeliveredBy)
                                  //   Row(
                                  //     children: [
                                  //       Text(
                                  //         "Delivered By: ",
                                  //         style: AppTextStyles.MetropolisRegular.copyWith(
                                  //             fontSize: 12, color: Colors.black),
                                  //       ),
                                  //       Text(
                                  //         "Name",
                                  //         style: AppTextStyles.MetropolisRegular.copyWith(
                                  //             fontSize: 12, color: const Color(0xFF858585)),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // const SizedBox(height: 8),
                                  // if (isPreparing)
                                  //   Align(
                                  //     alignment: Alignment.centerRight,
                                  //     child: GradientButton(
                                  //       height: 30,
                                  //       width: 90,
                                  //       onTap: () {
                                  //         print("Preparing button tapped!");
                                  //         // Add your onTap logic here
                                  //       },
                                  //     ),
                                  //   ),
                                  // if (isDelivered)
                                  //   Align(
                                  //     alignment: Alignment.centerRight,
                                  //     child: Text(
                                  //       "Delivered",
                                  //       style: AppTextStyles.MetropolisMedium.copyWith(
                                  //         fontSize: 12,
                                  //         color: Colors.black,
                                  //       ),
                                  //     ),
                                  //   ),
                                ],
                              ),
                            ),

                            // // Vertical Divider
                            // isShowScan
                            //     ? Container(
                            //   width: 1,
                            //   color: Colors.black.withOpacity(0.1),
                            //   margin: const EdgeInsets.only(left: 6, right: 10),
                            // )
                            //     : const SizedBox.shrink(),
                            //
                            // // Wallet Balance Section
                            // isShowScan && !isNoImage
                            //     ? Column(
                            //   crossAxisAlignment: CrossAxisAlignment.end,
                            //   children: [
                            //     const SizedBox(height: 8),
                            //
                            //     Image.asset(
                            //       image,
                            //       width: 36,
                            //       height: 36,
                            //     ),
                            //
                            //     const SizedBox(height: 8),
                            //     // Divider
                            //     Container(
                            //       width: 40, // Adjust as needed
                            //       height: 1,
                            //       color: Colors.grey[300],
                            //     ),
                            //     const SizedBox(height: 8),
                            //     const SizedBox(height: 4),
                            //     Text(
                            //       price,
                            //       style: AppTextStyles.MetropolisMedium.copyWith(
                            //         fontSize: 16,
                            //         color: Colors.black,
                            //       ),
                            //     ),
                            //   ],
                            // )
                            //     : const SizedBox.shrink(),

                            // isNoImage
                            //     ? Column(
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Text(
                            //       price,
                            //       style: AppTextStyles.MetropolisMedium.copyWith(
                            //         fontSize: 16,
                            //         color: Colors.black,
                            //       ),
                            //     ),
                            //   ],
                            // )
                            //     : const SizedBox.shrink()
                          ],
                        ),
                      );
                        // return const Padding(
                        //   padding:  EdgeInsets.all(16),
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       // Order Details
                        //       const WalletBalanceCard(
                        //         isEdit: false,
                        //         walletDesc: 'Wallet Remaining Balance',
                        //         price: '\$250',
                        //         isShowScan: true,
                        //         isNoImage: true,
                        //         isPreparing: false,
                        //         isDelivered: false,
                        //         isStaff: false,
                        //         isType: false,
                        //         isDuration: false,
                        //       ),
                        //     ],
                        //   ),
                        // );
                      },
                    ),
                  ],
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child:  CustomButton(
                text: 'Confirm', onPressed: () {}, isLoading: false.obs),
                ),
              ],

            ),
          ),
        ),
      ),
    );
  }
}
// class CafeteriaHistoryDetailsView
//     extends GetView<CafeteriaHistoryDetailsController> {
//   const CafeteriaHistoryDetailsView({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//         Align(
//           alignment: Alignment.center,
//           child: Text(
//
//              'History', // Title text
//             style: AppTextStyles.MetropolisMedium.copyWith(
//               fontSize: 18,
//               color: const Color(0xFF434343),
//             ),
//           ),
//         ),
//             // Row with month/year and calendar icon
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
//               child: RichText(
//                 text: TextSpan(
//                   children: [
//                     TextSpan(
//                       text: 'July ',
//                       style: AppTextStyles.RobotoLight.copyWith(
//                         fontSize: 18,
//                         color: const Color(0xFF2E2E2E),
//                       ),
//                     ),
//                     TextSpan(
//                       text: '2024',
//                       style: AppTextStyles.RobotoBold.copyWith(
//                         fontSize: 18,
//                         color: const Color(0xFF2E2E2E),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             const SizedBox(width: 8),
//             Center(
//               child: Image.asset(
//                 'assets/images/userimg.png', // Change to your image asset
//                 width: 125,
//                 height: 125,
//               ),
//             ),
//
//             // First custom Row with text and image
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Student Photo',
//                     style: AppTextStyles.MetropolisMedium.copyWith(
//                       fontSize: 14,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             // Second custom Row with container, image, and texts
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     width: 166,
//                     height: 183,
//                     decoration: BoxDecoration(
//                       color: Colors.white
//                           .withOpacity(0.9), // Optional background color
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Column(
//                       children: [
//                         // Image taking 80% of the container height
//                         Image.asset(
//                           'assets/images/gra.png', // Change to your image asset
//                           width: double.infinity,
//                           height: 153, // 80% of container height
//                           fit: BoxFit.contain,
//                         ),
//                         // Bottom row with text and price
//                         const Spacer(),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'Chicken Gravy',
//                               style: AppTextStyles.MetropolisMedium.copyWith(
//                                 fontSize: 16,
//                               ),
//                             ),
//                             Text(
//                               '\$25',
//                               style: AppTextStyles.MetropolisMedium.copyWith(
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             // ListView of WalletBalanceCards
//             // ignore: prefer_const_constructors
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//               child: const WalletBalanceCard(
//                 isEdit: false,
//                 walletDesc: 'Wallet Remaining Balance',
//                 price: '\$250',
//                 isShowScan: true,
//                 isNoImage: true,
//                 isPreparing: false,
//                 isDelivered: false,
//                 isStaff: false,
//                 isType: false,
//                 isDuration: false,
//               ),
//             ),
//
//             CustomButton(
//                 text: 'Confirm', onPressed: () {}, isLoading: false.obs),
//            const SizedBox(
//               height: 16,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
