import 'package:get/get.dart';

import '../../../../presentation/payment_page/controllers/payment_page.controller.dart';

class PaymentPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentPageController>(
      () => PaymentPageController(),
    );
  }
}
