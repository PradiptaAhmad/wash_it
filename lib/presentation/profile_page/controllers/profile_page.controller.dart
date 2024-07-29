import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wash_it/config.dart';
import 'package:http/http.dart' as http;
import 'package:wash_it/infrastructure/navigation/routes.dart';

import '../../../infrastructure/theme/themes.dart';

class ProfileController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  var userName = 'Nama Pengguna'.obs;
  var email = 'email@example.com'.obs;
  var phoneNumber = '081234567890'.obs;
  var isLoading = true.obs;
  final userData = {}.obs;

  GetStorage box = GetStorage();

  Future<void> fetchUserData() async {
    try {
      isLoading.value = true;
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(
        Uri.parse('$url/users/me'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body)['user'];
        userData.value = jsonResponse; // Store raw JSON in userData
        isLoading.value = false;
      } else {
        Get.snackbar('Error', '${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    final url = ConfigEnvironments.getEnvironments()['url'];
    final token = box.read('token');

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await http.post(
        Uri.parse("${url}/users/logout"),
        headers: headers,
      );

      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", "Anda telah berhasil logout",
            snackPosition: SnackPosition.TOP, backgroundColor: successColor);
        box.remove('token');
        Get.offAllNamed(Routes.LOGIN_PAGE);
      } else {
        Get.snackbar("Gagal ${response.statusCode}", "Gagal logout",
            snackPosition: SnackPosition.TOP, backgroundColor: warningColor);
      }
    } catch (e) {
      Get.snackbar("Gagal", e.toString(),
          snackPosition: SnackPosition.TOP, backgroundColor: warningColor);
      print(e);
    }
  }

  Future<void> updateUserNameData() async {
    isLoading.value = true;
    final url = ConfigEnvironments.getEnvironments()['url'];
    final token = box.read('token');

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var data = {
      'username': userName.value,
    };

    try {
      final response = await http.post(
        Uri.parse("${url}/users/update/username"),
        headers: headers,
        body: data,
      );

      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", "Username telah berhasil diganti",
            snackPosition: SnackPosition.TOP, backgroundColor: successColor);
        isLoading.value = false;
        fetchUserData();
        Get.offNamed(Routes.NAVBAR);
      } else {
        Get.snackbar(
            "Gagal ${response.statusCode}", "Username gagal untuk diganti",
            snackPosition: SnackPosition.TOP, backgroundColor: warningColor);
      }
    } catch (e) {
      Get.snackbar("Gagal", e.toString(),
          snackPosition: SnackPosition.TOP, backgroundColor: warningColor);
      print(e);
    }
  }

  Future<void> updateEmailData() async {
    isLoading.value = true;
    final url = ConfigEnvironments.getEnvironments()['url'];
    final token = box.read('token');

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var data = {
      'email': email.value,
    };

    try {
      final response = await http.post(
        Uri.parse("${url}/users/update/email"),
        headers: headers,
        body: data,
      );

      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", "Email telah berhasil diganti",
            snackPosition: SnackPosition.TOP, backgroundColor: successColor);
        isLoading.value = false;
        fetchUserData();
        Get.offNamed(Routes.NAVBAR);
      } else {
        Get.snackbar(
            "Gagal ${response.statusCode}", "Email gagal untuk diganti $data",
            snackPosition: SnackPosition.TOP, backgroundColor: warningColor);
      }
    } catch (e) {
      Get.snackbar("Gagal", e.toString(),
          snackPosition: SnackPosition.TOP, backgroundColor: warningColor);
      print(e);
    }
  }

  Future<void> updateUserPhoneData() async {
    isLoading.value = true;
    final url = ConfigEnvironments.getEnvironments()['url'];
    final token = box.read('token');

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var data = {
      'phone': phoneNumber.value,
    };

    try {
      final response = await http.post(
        Uri.parse("${url}/users/update/phone"),
        headers: headers,
        body: data,
      );

      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", "Nomor telepon telah berhasil diganti",
            snackPosition: SnackPosition.TOP, backgroundColor: successColor);
        isLoading.value = false;
        fetchUserData();
        Get.offNamed(Routes.NAVBAR);
      } else {
        // Try to decode the JSON response
        var responseBody = response.body;
        var jsonResponse;
        try {
          jsonResponse = json.decode(responseBody);
        } catch (e) {
          jsonResponse = null;
        }

        if (jsonResponse != null &&
            jsonResponse['message'] == 'validation.unique' &&
            jsonResponse['errors'] != null &&
            jsonResponse['errors']['phone'] != null) {
          Get.snackbar("Gagal", "Nomor telepon sudah digunakan",
              snackPosition: SnackPosition.TOP, backgroundColor: warningColor);
        } else {
          Get.snackbar("Gagal ${response.statusCode}",
              "Nomor telepon gagal untuk diganti $data",
              snackPosition: SnackPosition.TOP, backgroundColor: warningColor);
        }
      }
    } catch (e) {
      Get.snackbar("Gagal", e.toString(),
          snackPosition: SnackPosition.TOP, backgroundColor: warningColor);
      print(e);
    }
  }

  void updateUserName(String newUserName) {
    userName.value = newUserName;
  }

  void updateEmail(String newEmail) {
    email.value = newEmail;
  }

  void updatePhoneNumber(String newPhoneNumber) {
    phoneNumber.value = newPhoneNumber;
  }

  void updatePassword(String newPassword) {
    // Handle password update logic
  }

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
