import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../config.dart';
import '../../../infrastructure/theme/themes.dart';
import '../../../widgets/popup/custom_pop_up.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  var isLoading = false.obs;
  final laundryList = [].obs;
  var ordersList = [].obs;
  var jenisList = [].obs;
  final userData = {}.obs;
  var addressData = {}.obs;

  GetStorage box = GetStorage();

  Future<void> fetchOrdersData() async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(
        Uri.parse('$url/orders/all'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body)['order'];
        ordersList.value = jsonResponse;
      } else {
        customPopUp("Error, Kode(${response.statusCode})", warningColor);
      }
    } catch (e) {
      customPopUp("Error, Kode(${e.toString()})", warningColor);
    }
  }

  Future<void> fetchUserData() async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token.toString()}',
      };

      final response = await http.get(
        Uri.parse('$url/users/me'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body)['user'];
        userData.value = jsonResponse; // Store raw JSON in userData
      } else {
        customPopUp("Error, Kode(${response.statusCode})", warningColor);
      }
    } catch (e) {
      customPopUp("Error, Kode(${e.toString()})", warningColor);
    }
  }

  Future<void> getPrimaryAddress() async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token.toString()}',
      };

      final response = await http.get(
        Uri.parse('$url/addresses/primary'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body)['data'];
        addressData.value = jsonResponse;
      } else if (response.statusCode == 404) {
      } else {
        customPopUp("Error, Kode(${response.statusCode})", warningColor);
      }
    } catch (e) {
      customPopUp("Error, Kode(${e.toString()})", warningColor);
    }
  }

  Future<void> getLaundryServices() async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token.toString()}',
      };

      final response = await http.get(
        Uri.parse('$url/laundry/all'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body)['data'];
        laundryList.value = jsonResponse;
      } else {
        customPopUp("Error, Kode(${response.statusCode})", warningColor);
      }
    } catch (e) {
      customPopUp("Error, Kode(${e.toString()})", warningColor);
    }
  }

  Future<void> onRefresh() async {
    isLoading.value = true;
    await fetchOrdersData();
    await fetchUserData();
    await getPrimaryAddress();
    await getLaundryServices();
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    onRefresh();
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
