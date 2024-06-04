import 'package:get/get.dart';
import 'package:wash_it/presentation/chat_page/controllers/chat_controller.dart';

class ChatControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(
          () => ChatController(),
    );
  }
}
