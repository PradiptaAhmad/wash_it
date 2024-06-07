import 'package:get/get.dart';

import '../../../../presentation/transaction_page/controllers/metode_transaction_controller.dart';

class MetodeTransactionControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MetodeTransactionController>(
          () => MetodeTransactionController(),
    );
  }
}
