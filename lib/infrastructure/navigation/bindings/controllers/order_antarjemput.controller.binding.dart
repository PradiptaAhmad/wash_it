import 'package:get/get.dart';
import 'package:wash_it/presentation/order_antarjemput/controllers/order_antarjemput.controller.dart';
import 'package:wash_it/presentation/order_antarjemput/order_view.dart';

class OrderAntarJemputPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderAntarJemputController>(
      () => OrderAntarJemputController(),
    );
  }
}
