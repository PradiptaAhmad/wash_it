import 'package:get/get.dart';

import '../../../../presentation/history_page/controllers/history_page.controller.dart';

class HistoryPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryPageController>(
      () => HistoryPageController(),
    );
  }
}
