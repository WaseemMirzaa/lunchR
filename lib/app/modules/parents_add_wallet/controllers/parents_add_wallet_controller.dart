import 'package:get/get.dart';

class ParentsAddWalletController extends GetxController {
  // Checkbox state
  var isMonthlyReloadEnabled = false.obs;

  // Selected index for peso options
  var selectedIndex = (-1).obs; // -1 means no peso is selected

  // Amount entered
  var amount = ''.obs;

  // Updates the amount based on peso selection
  void selectPeso(int index, int peso) {
    selectedIndex.value = index;
    amount.value = peso.toString();
  }

  // Clears peso selection when the user types manually
  void clearSelectionOnTyping(String value) {
    if (value.isNotEmpty) {
      selectedIndex.value = -1;
    }
    amount.value = value;
  }
}
