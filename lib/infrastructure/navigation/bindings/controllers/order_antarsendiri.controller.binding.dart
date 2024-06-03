import 'package:get/get.dart';
import 'package:wash_it/infrastructure/navigation/bindings/controllers/order_controller.dart';

class OrderAntarSendiriPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderController>(
          () => OrderController(),
    );
  }
}