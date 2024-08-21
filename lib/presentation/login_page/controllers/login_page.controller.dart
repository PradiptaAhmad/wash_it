import 'dart:convert';

import 'package:dynamic_multi_step_form/dynamic_multi_step_form.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wash_it/config.dart';
import 'package:http/http.dart' as http;
import 'package:wash_it/infrastructure/navigation/routes.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';
import 'package:wash_it/widgets/popup/custom_pop_up.dart';

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
      if (user['email_verified_at'] == null) {
        Get.toNamed(Routes.VERIFICATION_PAGE, arguments: 'login');
      } else {
        FocusScope.of(Get.overlayContext!).unfocus();
        customPopUp(
          "Berhasil login",
          successColor,
        );
        Get.offAllNamed(Routes.NAVBAR);
      }
    } else {
      FocusScope.of(Get.overlayContext!).unfocus();
      customPopUp(
          "Gagal untuk melanjutkan login. Kode error(${response.statusCode})",
          warningColor);
      isLoading.value = false;
    }
  }

  Future<void> forgotPassword() async {
    isLoading.value = true;
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      var data = {
        'email': email.value,
      };
      var headers = {
        'Accept': 'application/json',
      };

      var response = await http.post(
        Uri.parse("$url/users/forgot-password/checkEmail"),
        headers: headers,
        body: data,
      );

      if (response.statusCode == 200) {
        final status = json.decode(response.body)['status'];
        switch (status) {
          case 'success':
            closeKeyboard();
            customPopUp("Berhasil mengirim email reset password", successColor);
            Get.toNamed(Routes.VERIFICATION_PAGE,
                arguments: ['otp-login', email.value]);
            break;
          case 'failed':
            closeKeyboard();
            customPopUp("Mohon tunggu 5 menit", warningColor);
            break;
          default:
        }
      } else if (response.statusCode == 422) {
        customPopUp("Email belum di input, silahkan input ulang", warningColor);
      } else {
        customPopUp(
            "Gagal untuk reset password. Kode error(${response.statusCode})",
            warningColor);
      }
    } catch (e) {
      print(e);
    } finally {
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
