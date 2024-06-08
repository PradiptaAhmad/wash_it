import 'package:get/get.dart';

import '../../../../presentation/receipt_page/controllers/receipt_page.controller.dart';

class ReceiptPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReceiptPageController>(
      () => ReceiptPageController(),
    );
  }
}
