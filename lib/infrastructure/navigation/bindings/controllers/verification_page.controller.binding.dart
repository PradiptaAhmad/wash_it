import 'package:get/get.dart';

import '../../../../presentation/verification_page/controllers/verification_page.controller.dart';

class VerificationPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerificationPageController>(
      () => VerificationPageController(),
    );
  }
}
