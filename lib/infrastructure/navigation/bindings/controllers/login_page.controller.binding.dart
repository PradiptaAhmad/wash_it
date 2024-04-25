import 'package:get/get.dart';

import '../../../../presentation/login_page/controllers/login_page.controller.dart';

class LoginPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginPageController>(
      () => LoginPageController(),
    );
  }
}
