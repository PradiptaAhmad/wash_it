import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../config.dart';
import 'package:http/http.dart' as http;

class OrderAntarJemputController extends GetxController {

  final count = 0.obs;
  var ordername = ''.obs;
  var phonenumber = ''.obs;
  var ordertype = ''.obs;
  var address = ''.obs;
  var pickupdate = ''.obs;

  var isLoading = true.obs;
  final userData = {}.obs;

  GetStorage box = GetStorage();

  get ordersList => null;

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
        Uri.parse('$url/orders/new'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body)['user'];
      } else {
        Get.snackbar('Error', '${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void updateOrderName(String newOrderName) {
    ordername.value = newOrderName;
  }
  void updatePhoneNumber(String newPhoneNumber) {
    phonenumber.value = newPhoneNumber;
  }
  void updateOrderType(String newOrderType) {
    ordertype.value = newOrderType;
  }
  void updateAddress(String newAddress) {
    address.value = newAddress;
  }
  void updatePickupDate(String newPickupDate) {
    pickupdate.value = newPickupDate;
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

  void fetchOrdersData() {}
}