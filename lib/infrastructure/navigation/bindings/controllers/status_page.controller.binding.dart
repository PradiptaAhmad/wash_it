import 'package:get/get.dart';

import '../../../../presentation/status_page/controllers/status_page.controller.dart';

class StatusPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StatusPageController>(
      () => StatusPageController(),
    );
  }
}
