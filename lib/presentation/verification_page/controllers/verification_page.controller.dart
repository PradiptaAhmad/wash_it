import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:wash_it/config.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';

import '../../../infrastructure/navigation/routes.dart';

class VerificationPageController extends GetxController {
  final count = 0.obs;
  final box = GetStorage();
  final url = ConfigEnvironments.getEnvironments()['url'];
  final userData = {}.obs;

  var otp = "".obs;

  // Rundown Timer
  Timer _timer = Timer(Duration(seconds: 60), () {});
  var timeleft = 120.obs;

  Future<void> getUserData() async {
    final token = box.read('token');

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    try {
      final response = await http.get(
        Uri.parse("${url}/users/me"),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        userData.value = data['user'];
      } else {
        Get.snackbar("Gagal", "Gagal mengambil data user",
            snackPosition: SnackPosition.TOP, backgroundColor: warningColor);
      }
    } catch (e) {
      Get.snackbar("Gagal", "Gagal mengambil data user",
          snackPosition: SnackPosition.TOP, backgroundColor: warningColor);
    }
  }

  Future<void> sendOtp() async {
    final token = box.read('token');

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.post(
        Uri.parse("${url}/users/send-otp"),
        headers: headers,
      );

      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", "Kode OTP telah dikirim",
            snackPosition: SnackPosition.TOP, backgroundColor: successColor);
      } else {
        Get.snackbar("Gagal", "Kode OTP gagal dikirim",
            snackPosition: SnackPosition.TOP, backgroundColor: warningColor);
      }
    } catch (e) {
      Get.snackbar("Gagal", "Kode OTP gagal dikirim",
          snackPosition: SnackPosition.TOP, backgroundColor: warningColor);
    }
  }

  Future<void> verifyOtp(String pinCode) async {
    final token = box.read('token');

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var data = {
      'otp': '$pinCode',
    };

    try {
      final response = await http.post(
        Uri.parse("${url}/users/verify-otp"),
        headers: headers,
        body: data,
      );

      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", "Kode OTP berhasil diverifikasi",
            snackPosition: SnackPosition.TOP, backgroundColor: successColor);
        Get.offAllNamed(Routes.NAVBAR);
      } else {
        Get.snackbar(
            "Gagal ${response.statusCode}", "Kode OTP gagal diverifikasi $data",
            snackPosition: SnackPosition.TOP, backgroundColor: warningColor);
      }
    } catch (e) {
      // Get.snackbar("Gagal", "Kode OTP gagal terprogress",
      //     snackPosition: SnackPosition.TOP, backgroundColor: warningColor);
      Get.snackbar("Gagal", e.toString(),
          snackPosition: SnackPosition.TOP, backgroundColor: warningColor);
      print(e);
    }
  }

  String formatPhoneNumber() {
    final phone = userData['phone'].toString();
    // final formattedPhone =
    //     "+62-${phone.substring(1, 4)}-${phone.substring(4, 8)}-${phone.substring(8, 12)}";
    return phone;
  }

  Future<void> startTimer() async {
    timeleft.value = 120;
    _timer.cancel();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeleft.value == 0) {
        timer.cancel();
      } else {
        timeleft.value--;
      }
    });
  }

  @override
  void onInit() {
    getUserData();
    sendOtp();
    startTimer();
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
