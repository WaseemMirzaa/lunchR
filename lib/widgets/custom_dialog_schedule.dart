import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luncher/config/app_colors.dart';
import 'package:luncher/config/app_text_style.dart';
import 'package:luncher/widgets/reuse_button.dart';

class ScheduleDialogController extends GetxController {
  final RxInt repeatCount = 1.obs;
  final RxString repeatUnit = 'day'.obs;
  final RxList<bool> selectedDays = List.generate(7, (index) => index == 0).obs;
  final RxList<bool> selectedTimes = List.generate(3, (index) => false).obs;

  // Show day selection for both week and month
  bool get showDaySelection =>
      repeatUnit.value.contains('week') || repeatUnit.value.contains('month') || repeatUnit.value.contains('day');

  List<String> get timeUnits => ['day', 'week', 'month'];

  List<String> get availableTimes => ['12am', '2pm', '5pm'];

  String get currentRepeatUnit {
    String baseUnit = repeatUnit.value;
    if (repeatCount.value > 1) {
      return baseUnit + 's';
    }
    return baseUnit;
  }

  void incrementCount() {
    if (repeatCount.value < 99) {
      repeatCount.value++;
    }
  }

  void decrementCount() {
    if (repeatCount.value > 1) {
      repeatCount.value--;
    }
  }

  void toggleDay(int index) {
    selectedDays[index] = !selectedDays[index];
    selectedDays.refresh();
  }

  void toggleTime(int index) {
    selectedTimes[index] = !selectedTimes[index];
    selectedTimes.refresh();
  }

  void updateRepeatUnit(String? value) {
    if (value != null) {
      // Remove 's' if present and store base form
      repeatUnit.value = value.replaceAll('s', '');

      if (value.contains('day')) {
        selectedDays.value = List.generate(7, (index) => false);
      }
    }
  }

  Map<String, dynamic> getScheduleData() {
    return {
      'repeatCount': repeatCount.value,
      'repeatUnit': currentRepeatUnit,
      'selectedDays': showDaySelection ? selectedDays.toList() : [],
    };
  }
}

class ScheduleDialog extends StatelessWidget {
  final controller = Get.find<ScheduleDialogController>();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    const double defaultPadding = 16.0;
    const double smallPadding = 8.0;

    return Dialog(
      backgroundColor: const Color(0xFFF2F2F2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        // Increased width to 98% of screen width
        width: screenSize.width - 32,
        height: screenSize.height * 0.48,
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Schedule',
              style: AppTextStyles.MetropolisBold.copyWith(
                color: Color(0xFF434343),
                fontSize: 18,
              ),
            ),
            const SizedBox(height: defaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Repeat every',
                  style: AppTextStyles.MetropolisRegular.copyWith(fontSize: 12),
                ),
                const SizedBox(width: smallPadding),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: controller.decrementCount,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.whiteColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              '-',
                              style: AppTextStyles.PoppinsRegular.copyWith(
                                fontSize: 11,
                                color: const Color(0xFF1D1D1D),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: smallPadding),
                      Obx(() => Text(
                            '${controller.repeatCount.value}',
                            style: AppTextStyles.PoppinsRegular.copyWith(
                              fontSize: 11,
                              color: const Color(0xFF1D1D1D),
                            ),
                          )),
                      const SizedBox(width: smallPadding),
                      GestureDetector(
                        onTap: controller.incrementCount,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.whiteColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              '+',
                              style: AppTextStyles.PoppinsRegular.copyWith(
                                fontSize: 11,
                                color: const Color(0xFF1D1D1D),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: smallPadding),
                Container(
                  width: 85,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: Obx(() {
                        final List<String> options =
                            controller.timeUnits.map((unit) {
                          return controller.repeatCount.value > 1
                              ? '${unit}s'
                              : unit;
                        }).toList();

                        return DropdownButton<String>(
                          value: controller.currentRepeatUnit,
                          items: options.map((String unit) {
                            return DropdownMenuItem<String>(
                              value: unit,
                              child: Text(
                                unit,
                                style: AppTextStyles.PoppinsRegular.copyWith(
                                  fontSize: 11,
                                  color: const Color(0xFF1D1D1D),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: controller.updateRepeatUnit,
                          isDense: true,
                          icon: const Icon(Icons.keyboard_arrow_down_rounded,
                              color: Colors.black, size: 12),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: defaultPadding),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Available at',
                    style: AppTextStyles.MetropolisRegular.copyWith(
                        fontSize: 12),
                  ),
                  ...List.generate(controller.availableTimes.length, (index) {
                    return GestureDetector(
                      onTap: () => controller.toggleTime(index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 12),
                        decoration: BoxDecoration(
                          color: controller.selectedTimes[index]
                              ? const Color(0xFFFFF3E0)
                              : const Color(0xFFF2F2F2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: controller.selectedTimes[index]
                                ? const Color(0xFFFF9A0D)
                                : Colors.grey.shade400,
                            width: 1.5,
                          ),
                        ),
                        child: Text(
                          controller.availableTimes[index],
                          style: AppTextStyles.MetropolisRegular.copyWith(
                            fontSize: 12,
                            color: controller.selectedTimes[index]
                                ? Colors.black87
                                : const Color(0xFFFF9A0D),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            Obx(() => controller.showDaySelection
                ? Column(
                    children: [
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            'Repeat on',
                            style: AppTextStyles.MetropolisRegular.copyWith(
                                fontSize: 12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
                            .asMap()
                            .entries
                            .map(
                              (entry) => GestureDetector(
                                onTap: () => controller.toggleDay(entry.key),
                                child: Container(
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(
                                    color: controller.selectedDays[entry.key]
                                        ? const Color(0xFFFFF3E0)
                                        : const Color(0xFFF2F2F2),
                                    border: Border.all(
                                      color: controller.selectedDays[entry.key]
                                          ? const Color(0xFFFF9A0D)
                                          : Colors.grey.shade400,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    entry.value,
                                    style:
                                        AppTextStyles.PoppinsRegular.copyWith(
                                      fontSize: 13,
                                      color: controller.selectedDays[entry.key]
                                          ? Colors.black87
                                          : const Color(0xFFFF9A0D),
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(() {
                        final selectedTimes = controller.selectedTimes
                            .asMap()
                            .entries
                            .where((entry) => entry.value)
                            .map((entry) => controller.availableTimes[entry.key])
                            .join(', ');

                        final selectedDays = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
                            .asMap()
                            .entries
                            .where((entry) => controller.selectedDays[entry.key])
                            .map((entry) => entry.value)
                            .join(', ');

                        if (selectedTimes.isEmpty) {
                          return const SizedBox.shrink();
                        }

                        String scheduleMessage;

                        if (controller.repeatUnit.value == 'week') {
                          scheduleMessage = 'Your order is scheduled for $selectedTimes on $selectedDays ${controller.repeatUnit.value}';
                        }
                        if (controller.repeatUnit.value == 'month') {
                          scheduleMessage = 'Your order is scheduled for $selectedTimes on $selectedDays every week this ${controller.repeatUnit.value}';
                        } else {
                          scheduleMessage = 'Your order is scheduled for $selectedTimes $selectedDays daily';
                        }

                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            scheduleMessage,
                            style: AppTextStyles.MetropolisRegular.copyWith(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }),
                    ],
                  )
                : const SizedBox.shrink()),
            const Spacer(),
            CustomButton(
                text: 'Confirm',
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                isLoading: false.obs)
          ],
        ),
      ),
    );
  }
}
