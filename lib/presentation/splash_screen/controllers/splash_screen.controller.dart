import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wash_it/infrastructure/navigation/routes.dart';

class SplashPageController extends GetxController {
  final box = GetStorage();
  var text = 'SplashScreen'.obs;
  void checkLogin() async {
    if (box.read('token') != null) {
      Get.offNamed(Routes.NAVBAR);
    } else {
      Get.offNamed(Routes.LOGIN_PAGE);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    Future.delayed(Duration(seconds: 3), () {
      checkLogin();
    });
    super.onInit();
  }
}
