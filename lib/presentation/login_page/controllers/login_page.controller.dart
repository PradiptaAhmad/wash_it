import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wash_it/config.dart';
import 'package:http/http.dart' as http;
import 'package:wash_it/infrastructure/navigation/routes.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';

class LoginPageController extends GetxController {
  // Password Visibility
  var isObsecure = true.obs;

  final _firebaseMessaging = FirebaseMessaging.instance;

  // Email and Password
  var email = ''.obs;
  var password = ''.obs;

  // Loading
  var isLoading = false.obs;

  // Other
  GetStorage box = GetStorage();

  Future<void> login() async {
    isLoading.value = true;
    String? notificationtoken;
    await _firebaseMessaging.getToken().then((value) {
      notificationtoken = value!;
    });
    final url = ConfigEnvironments.getEnvironments()["url"];
    print(url);
    var data = {
      'email': email.value,
      'password': password.value,
      'notification_token': notificationtoken,
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
      } else {
        Get.snackbar(
          "Sukses Login",
          "Selamat datang ${user['username']}",
          snackPosition: SnackPosition.TOP,
          backgroundColor: successColor,
        );
        Get.offAllNamed(Routes.NAVBAR);
      }
    } else {
      Get.snackbar("Gagal Login", json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: warningColor,
          colorText: primaryColor);
      isLoading.value = false;
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
