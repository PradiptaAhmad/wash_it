import 'package:get/get.dart';

import '../../../../presentation/notification_page/controllers/notification_page.controller.dart';

class NotificationPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationPageController>(
      () => NotificationPageController(),
    );
  }
}
