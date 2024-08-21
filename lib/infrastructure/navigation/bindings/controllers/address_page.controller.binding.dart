import 'package:get/get.dart';

import '../../../../presentation/address_page/controllers/address_page.controller.dart';

class AddressPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddressPageController>(
      () => AddressPageController(),
    );
  }
}
