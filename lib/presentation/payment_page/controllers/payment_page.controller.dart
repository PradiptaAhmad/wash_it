import 'package:get/get.dart';

class PaymentPageController extends GetxController {
  // Observable selectedMethod
  var selectedMethod = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Method to update the selected method
  void selectMethod(int methodIndex) {
    selectedMethod.value = methodIndex;
  }
}
