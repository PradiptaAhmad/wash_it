import 'package:get/get.dart';
import 'package:wash_it/presentation/transaction_page/controllers/payment_receipt_controller.dart';


class PaymentReceiptControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentReceiptController>(
      () => PaymentReceiptController(),
    );
  }
}
