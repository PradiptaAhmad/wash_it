import 'package:get/get.dart';
import 'package:wash_it/presentation/profile_page/controllers/profile_page.controller.dart';

class ProfilePageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
