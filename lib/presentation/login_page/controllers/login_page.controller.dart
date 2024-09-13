import 'dart:convert';

import 'package:dynamic_multi_step_form/dynamic_multi_step_form.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wash_it/config.dart';
import 'package:http/http.dart' as http;
import 'package:wash_it/infrastructure/navigation/routes.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';
import 'package:wash_it/widgets/popup/custom_pop_up.dart';

class LoginPageController extends GetxController {
  // Password Visibility
  var isObsecure = true.obs;

  // Email and Password
  var email = ''.obs;
  var password = ''.obs;

  // Loading
  var isLoading = false.obs;

  // Other
  final _firebaseMessaging = FirebaseMessaging.instance;
  GetStorage box = GetStorage();

  Future<void> login() async {
    isLoading.value = true;
    try {
      FocusScope.of(Get.overlayContext!).unfocus();
      String? notificationtoken;
      await _firebaseMessaging.getToken().then((value) {
        notificationtoken = value!;
      });
      final url = ConfigEnvironments.getEnvironments()["url"];
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
          customPopUp("Sukses, berhasil untuk masuk ke akun", successColor);
          Get.offAllNamed(Routes.NAVBAR);
        }
      } else if (response.statusCode == 401) {
        customPopUp(
            "Error, ada yang salah di antara email dan password", warningColor);
      } else {
        customPopUp("Error, Kode:${response.statusCode}", warningColor);
      }
    } catch (e) {
      customPopUp('Error, Gagal untuk masuk ke akun', warningColor);
      print(e);
    } finally {
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
            customPopUp(
                "Sukses, berhasil mengirim email reset password", successColor);
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
        customPopUp("Error, Kode:${response.statusCode}", warningColor);
      }
    } catch (e) {
      customPopUp('Error, Gagal untuk lupa Paswword', warningColor);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final url = ConfigEnvironments.getEnvironments()["url"];
        final notificationToken = await _firebaseMessaging.getToken();
        var data = {
          'token': googleAuth.accessToken,
          'notification_token': notificationToken,
        };
        var headers = {
          'Accept': 'application/json',
        };

        var response = await http.post(
          Uri.parse("$url/users/google/login"),
          headers: headers,
          body: data,
        );

        print(response.body);

        if (response.statusCode == 200) {
          final token = json.decode(response.body)['token'];
          final user = json.decode(response.body)['user'];
          box.write("token", token);
          if (user['email_verified_at'] == null) {
            Get.toNamed(Routes.VERIFICATION_PAGE, arguments: 'login');
          } else {
            FocusScope.of(Get.overlayContext!).unfocus();
            customPopUp(
                "Sukses, berhasil masuk menggunakan google", successColor);
            Get.offAllNamed(Routes.NAVBAR);
          }
        } else {
          FocusScope.of(Get.overlayContext!).unfocus();
          customPopUp("Error, Kode:${response.statusCode}", warningColor);
        }
      }
    } on Exception catch (e) {
      customPopUp('Error, Gagal untuk masuk menggunakan google', warningColor);
      print(e);
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
