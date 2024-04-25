import 'package:get/get.dart';

import '../../../../presentation/register_page/controllers/register_page.controller.dart';

class RegisterPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterPageController>(
      () => RegisterPageController(),
    );
  }
}
