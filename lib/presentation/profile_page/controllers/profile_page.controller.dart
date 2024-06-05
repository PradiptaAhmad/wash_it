import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wash_it/config.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  var userName = 'Nama Pengguna'.obs;
  var email = 'email@example.com'.obs;
  var phoneNumber = '081234567890'.obs;

  var isLoading = true.obs;

  final userData = {}.obs;

  final box = GetStorage();

  Future<void> fetchUserData() async {
    final url = ConfigEnvironments.getEnvironments()["url"];
    final token = box.read('token');

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(
      Uri.parse('$url/user'),
      headers: headers,
    );

    try {
      if (response.statusCode == 200) {
        userData.value = jsonDecode(response.body);
        isLoading.value = false;
      } else {
        Get.snackbar('Error', '${response.statusCode}');
        print(response.statusCode);
      }
    } catch (e) {
      Get.snackbar('Error ', e.toString());
      print(e);
    } finally {
      isLoading.value = false;
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
}
