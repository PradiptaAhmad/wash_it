import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../../config.dart';
import '../../../infrastructure/theme/themes.dart';

class HistoryPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final count = 0.obs;
  final laundries = [].obs;
  final jenisList = [].obs;
  var ordersList = [].obs;
  var rating = 0.0.obs;
  var review = ''.obs;
  var orderid = ''.obs;
  var isLoading = false.obs;
  late TabController tabController;

  GetStorage box = GetStorage();

  Future<void> fetchOrdersData() async {
    isLoading.value = true;
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token')?.toString();

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(
        Uri.parse('$url/histories/all'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body)['data'];
        ordersList.value = jsonResponse;
      } else {
        Get.snackbar('Error', '${response.statusCode}');
        print(response.statusCode);
      }
    } catch (e) {
      Get.snackbar('Error Catch', e.toString());
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createOrder(String orderTipe) async {
    try {
      isLoading.value = true;
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token.toString()}',
      };

      var data = {
        'rating': rating.value,
        'review': review.value,
        'order_id': orderid,
      };
      final response = await http.post(
        Uri.parse("${url}/orders/new"),
        headers: headers,
        body: data,
      );

      if (response.statusCode == 201) {
        Get.snackbar('Success', 'Ulasan berhasil dikirim',
            backgroundColor: successColor);
      } else {
        Get.snackbar('Error', '${response.statusCode}');
        print(response.body);
        print(data);
      }
    } catch (e) {
      Get.snackbar('Error catch', e.toString());
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getLaundries() async {
    isLoading.value = true;
    try {
      final url = ConfigEnvironments.getEnvironments()['url'];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var response = await http.get(
        Uri.parse('$url/laundry/all'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body)['data'];
        laundries.value = jsonResponse;

        jsonResponse.forEach((element) {
          jenisList.add(element['nama_laundry']);
        });
      } else {
        Get.snackbar('Error', '${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchOrdersData();
    getLaundries();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
  }

  void increment() => count.value++;
}
