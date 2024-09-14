import 'package:get/get.dart';

import '../../../../presentation/chat_page/controllers/chat_page.controller.dart';

class ChatPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatPageController>(
      () => ChatPageController(),
    );
  }
}
