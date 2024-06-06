import 'package:get/get.dart';
import 'package:wash_it/presentation/history_page/controllers/history_detail.controller.dart';

class HistoryDetailControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryDetailController>(
          () => HistoryDetailController(),
    );
  }
}
