import 'package:get/get.dart';
import 'package:wash_it/presentation/profile_page/profile_controller.dart';

class ProfilePageControllerBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ProfileController>(() => ProfileController());
  }

}