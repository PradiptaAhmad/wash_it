import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:wash_it/config.dart';
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
  
  //TODO: Implement RegisterPageController

  // Register Function

  Future<void> register() async {
    isLoading.value = true;
    final url = ConfigEnvironments.getEnvironments()["url"];
    print(url);
    var data = {
      'username': username.value,
      'email': email.value,
      'phone': phone.value,
      'password': password.value,
    };
    var headers = {
      'Accept': 'application/json',
    };

    final response = await http.post(
      Uri.parse("$url/users/register"),
      headers: headers,
      body: data,
    );

    if (response.statusCode == 200) {
      final user = json.decode(response.body)['user'];
      Get.snackbar("Sukses Daftar", "Selamat datang ${user['name']}",
          snackPosition: SnackPosition.TOP, backgroundColor: successColor);
    } else {
      Get.snackbar("Gagal Register", json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP, backgroundColor: warningColor);
    }
    isLoading.value = false;
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
