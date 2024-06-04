import 'package:get/get.dart';
import 'package:wash_it/infrastructure/navigation/bindings/controllers/order_controller.dart';
import 'package:wash_it/presentation/order_antarsendiri/controllers/order_antarjemput.controller.dart';

class OrderAntarSendiriPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderAntarSendiriController>(
      () => OrderAntarSendiriController(),
    );
  }
}
