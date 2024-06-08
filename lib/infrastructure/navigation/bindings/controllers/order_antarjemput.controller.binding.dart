import 'package:get/get.dart';

import '../../../../presentation/order_page/controllers/order_page.controller.dart';

class OrderAntarJemputPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderAntarJemputController>(
      () => OrderAntarJemputController(),
    );
  }
}
