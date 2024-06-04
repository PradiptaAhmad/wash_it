import 'package:get/get.dart';

import '../../../../presentation/transaction_page/controllers/transaction_page.controller.dart';

class TransactionPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionPageController>(
      () => TransactionPageController(),
    );
  }
}
