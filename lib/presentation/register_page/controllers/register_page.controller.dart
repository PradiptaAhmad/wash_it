import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:wash_it/config.dart';
import 'package:wash_it/infrastructure/navigation/routes.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';

class RegisterPageController extends GetxController {
  // Password Visibility
  var isObsecure = true.obs;

  // Loading
  var isLoading = false.obs;

  // Users Data
  var username = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;
  var password = ''.obs;

  // // Google Signin
  // final GoogleSignIn _googleSignIn = GoogleSignIn();

  // GetStorage
  GetStorage box = GetStorage();

  // Register Function
  Future<void> register() async {
    isLoading.value = true;
    try {
      final fcm_token = await FirebaseMessaging.instance.getToken();
      final url = ConfigEnvironments.getEnvironments()['url'];
      print(url);
      var data = {
        'username': username.value,
        'email': email.value,
        'phone': phone.value,
        'password': password.value,
        'notification_token': fcm_token,
      };
      var headers = {
        'Accept': 'application/json',
      };

      final response = await http.post(
        Uri.parse("$url/users/register"),
        headers: headers,
        body: data,
      );

      if (response.statusCode == 201) {
        final user = json.decode(response.body)['token'];
        box.write('token', user);
        Get.toNamed(Routes.VERIFICATION_PAGE,
            arguments: [json.decode(response.body)['user']]);
      } else {
        print(json.decode(response.body)['errors']);
        Get.snackbar("Gagal Register", json.decode(response.body)['message'],
            snackPosition: SnackPosition.TOP, backgroundColor: warningColor);
      }
    } catch (e) {
      Get.snackbar("Gagal Register", "Gagal Register, Silahkan Coba Lagi",
          snackPosition: SnackPosition.TOP, backgroundColor: warningColor);
    } finally {
      isLoading.value = false;
    }
  }

  // Future<void> googleSignIn() async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //     if (googleUser == null) {
  //       Get.snackbar('Auth Google Canceled', "You canceled google authentication", backgroundColor: warningColor);
  //     } else {

  //     }

  //   } catch(e) {
  //     throw e;
  //   }
  // }

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
