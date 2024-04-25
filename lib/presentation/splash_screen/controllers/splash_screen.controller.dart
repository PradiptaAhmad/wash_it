import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wash_it/config.dart';
import 'package:http/http.dart' as http;
import 'package:wash_it/infrastructure/navigation/routes.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';

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
