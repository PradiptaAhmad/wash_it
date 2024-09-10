import 'package:get/get.dart';

import '../../../../presentation/map_google/controllers/map_google.controller.dart';

class MapGoogleControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapGoogleController>(
      () => MapGoogleController(),
    );
  }
}
