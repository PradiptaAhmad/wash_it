import 'package:get/get.dart';

class RegisterPageController extends GetxController {
  // Password Visibility
  var isObsecure = true.obs;

  // Users Data
  var username = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;
  var password = ''.obs;
  
  //TODO: Implement RegisterPageController

  final count = 0.obs;
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

  void increment() => count.value++;
}
