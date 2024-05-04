import 'package:get/get.dart';
import 'package:wash_it/infrastructure/navigation/routes.dart';

class SplashPageController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(Duration(seconds: 3), () {
      Get.offNamed(Routes.LOGIN_PAGE);
    });
  }
}
