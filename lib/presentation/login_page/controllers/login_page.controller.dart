import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wash_it/config.dart';
import 'package:http/http.dart' as http;
import 'package:wash_it/infrastructure/navigation/routes.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';

class LoginPageController extends GetxController {
  // Password Visibility
  var isObsecure = false.obs;

  // Email and Password
  var email = ''.obs;
  var password = ''.obs;

  // Loading
  var isLoading = false.obs;

  // Other
  GetStorage box = GetStorage();

  Future<void> login() async {
    isLoading.value = true;
    final url = ConfigEnvironments.getEnvironments()["url"];
    var data = {
      'email': email.value,
      'password': password.value,
    };
    var headers = {
      'Accept': 'application/json',
    };

    var response = await http.post(
      Uri.parse("$url/users/login"),
      headers: headers,
      body: data,
    );

    if (response.statusCode == 200) {
      final token = json.decode(response.body)['token'];  
      final user = json.decode(response.body)['user'];
      box.write("token", token);
      if (user['phone_verified_at'] == null) {
        Get.toNamed(Routes.VERIFICATION_PAGE);
      }
      Get.snackbar("Sukses Login", "Selamat datang ${user['name']}",
          snackPosition: SnackPosition.TOP, backgroundColor: successColor);
      Get.offAllNamed(Routes.HOME);
    
    } else {
      Get.snackbar("Gagal Login", json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP, backgroundColor: warningColor);
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
