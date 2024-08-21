import 'dart:async';
import 'dart:convert';

import 'package:dynamic_multi_step_form/dynamic_multi_step_form.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:wash_it/config.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';
import 'package:wash_it/widgets/popup/custom_pop_up.dart';

import '../../../infrastructure/navigation/routes.dart';

class VerificationPageController extends GetxController {
  final count = 0.obs;
  final box = GetStorage();
  final url = ConfigEnvironments.getEnvironments()['url'];
  final userData = {}.obs;
  var isLoading = false.obs;
  late final argument;

  var otp = "".obs;

  // Rundown Timer
  Timer _timer = Timer(Duration(seconds: 60), () {});
  var timeleft = 120.obs;

  Future<void> getUserData() async {
    isLoading.value = true;
    try {
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

      final response = await http.get(
        Uri.parse("${url}/users/me"),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body)['user'];
        userData.value = jsonResponse;
        print(jsonResponse);
      } else {
        Get.snackbar("Gagal", "Gagal mengambil data user",
            snackPosition: SnackPosition.TOP, backgroundColor: warningColor);
      }
    } catch (e) {
      Get.snackbar("Gagal", "Gagal mengambil data user",
          snackPosition: SnackPosition.TOP, backgroundColor: warningColor);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendOtp() async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token.toString()}',
      };

      final response = await http.post(
        Uri.parse("${url}/users/otp/send/email"),
        headers: headers,
      );

      if (response.statusCode == 200) {
        FocusScope.of(Get.overlayContext!).unfocus();
        customPopUp("Kode OTP telah dikirim", successColor);
      } else {
        FocusScope.of(Get.overlayContext!).unfocus();
        customPopUp("Gagal mengirim kode OTP", warningColor);
      }
    } catch (e) {
      FocusScope.of(Get.overlayContext!).unfocus();
      customPopUp("Gagal mengirim kode OTP", warningColor);
    }
  }

  Future<void> verifyOtp(String pinCode) async {
    isLoading.value = true;
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token.toString()}',
      };

      var data = {
        'otp': '$pinCode',
      };

      final response = await http.post(
        Uri.parse("${url}/users/otp/verify/email"),
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
        print(data);
      }
    } catch (e) {
      // Get.snackbar("Gagal", "Kode OTP gagal terprogress",
      //     snackPosition: SnackPosition.TOP, backgroundColor: warningColor);
      Get.snackbar("Gagal", e.toString(),
          snackPosition: SnackPosition.TOP, backgroundColor: warningColor);
      print(e);
    } finally {
      isLoading.value = false;
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
    argument = Get.arguments;
    // userData.value = argument[0];
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
