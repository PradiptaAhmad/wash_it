import 'package:get/get.dart';

import '../../../../presentation/splash_screen/controllers/splash_screen.controller.dart';

class SplashControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashPageController>(
          () => SplashPageController(),
    );
  }
}