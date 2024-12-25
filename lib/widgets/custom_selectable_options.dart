import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luncher/config/app_text_style.dart';

class SelectableOptions extends StatelessWidget {
  final String title;
  final List<String> options;
  final RxString selectedOption; // Observable for selected option
  final bool isRowLayout; // Optional parameter for layout control

  const SelectableOptions({
    Key? key,
    required this.title,
    required this.options,
    required this.selectedOption,
    this.isRowLayout = false, // Default is false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isRowLayout) {
      // Single-row layout
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title
          Text(
            title,
            style: AppTextStyles.MetropolisMedium.copyWith(
              fontSize: 12,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 16), // Space between the title and options

          // Options in a horizontal row
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end, // Space options
              children: options.map((option) {
                return GestureDetector(
                  onTap: () {
                    // Update the selected option
                    selectedOption.value = option;
                  },
                  child: Row(
                    children: [
                      // Circular icon with Obx
                      const SizedBox(width: 8),
                      // Text for the option
                      Text(
                        option,
                        style: AppTextStyles.PoppinsRegular.copyWith(
                          fontSize: 10,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Obx(() {
                        return Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: selectedOption.value == option
                                ? Colors.orange // Selected state
                                : Colors.transparent, // Unselected state
                            border: Border.all(
                              color: selectedOption.value == option
                                  ? const Color(0xFFE2E2E2) // Selected border
                                  : const Color(
                                      0xFFE2E2E2), // Unselected border
                            ),
                          ),
                          child: Icon(
                            selectedOption.value == option
                                ? Icons.radio_button_checked
                                : Icons.radio_button_unchecked,
                            color: Colors.transparent, // Transparent background
                            size: 10,
                          ),
                        );
                      }),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      );
    } else {
      // Default vertical layout
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            title,
            style: AppTextStyles.MetropolisMedium.copyWith(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12), // Space between title and options

          // Options in a Row
          Row(
            children: options.map((option) {
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Update the selected option
                    selectedOption.value = option;
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Circular icon using Obx for state

                      const SizedBox(width: 42),

                      Obx(() {
                        return Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: selectedOption.value == option
                                ? Colors.orange // Selected state
                                : Colors.transparent, // Unselected state
                            border: Border.all(
                              color: selectedOption.value == option
                                  ? const Color(0xFFE2E2E2) // Selected border
                                  : const Color(
                                      0xFFE2E2E2), // Unselected border
                            ),
                          ),
                          child: Icon(
                            selectedOption.value == option
                                ? Icons.radio_button_checked
                                : Icons.radio_button_unchecked,
                            color: Colors.transparent, // Transparent background
                            size: 10,
                          ),
                        );
                      }),
                      const SizedBox(
                          width: 8), // Space between the icon and text

                      // Option Text
                      Flexible(
                        child: Text(
                          option,
                          style: AppTextStyles.MetropolisRegular.copyWith(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis, // Handle long text
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      );
    }
  }
}
