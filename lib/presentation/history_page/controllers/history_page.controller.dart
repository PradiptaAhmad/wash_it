import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:wash_it/widgets/popup/custom_pop_up.dart';
import '../../../config.dart';
import '../../../infrastructure/theme/themes.dart';

class HistoryPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final count = 0.obs;
  final isSelected = 0.obs;
  final laundries = [].obs;
  final jenisList = [].obs;
  var ordersList = [].obs;
  var filteredOrdersList = [].obs;
  var rating = 0.0.obs;
  var review = ''.obs;
  var orderid = ''.obs;
  var isLoading = false.obs;
  var reviewDesc = ''.obs;
  var reviewStar = 0.0.obs;
  var pagination = 1.obs;
  var isMaxPage = false.obs;
  var isLoadingMore = false.obs;
  late TabController tabController;
  final scrollController = ScrollController();

  GetStorage box = GetStorage();

  Future<void> getHistoryOrders() async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token')?.toString();

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(
        Uri.parse('$url/histories/all?page=${pagination.value}'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body)['data'];
        ordersList.addAll(jsonResponse);
        print(ordersList.isEmpty);
      } else {
        Get.snackbar('Error', '${response.statusCode}');
        print(response.statusCode);
      }
    } catch (e) {
      Get.snackbar('Error Catch', e.toString());
      print(e);
    }
  }

  Future<void> getLaundries() async {
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
    }
  }

  Future<void> fetchHistoryByStatus(String status) async {
    try {
      isLoading.value = true;
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token.toString()}',
      };

      final response = await http.get(
        Uri.parse(
            "${url}/histories/filter/status?status=${status}&page=${pagination.value}"),
        headers: headers,
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)['data'];
        if (data.isEmpty) {
          isMaxPage.value = true;
        }
        filteredOrdersList.addAll(jsonDecode(response.body)['data']);
      } else {
        Get.snackbar('Error', '${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error catch', e.toString());
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void applyFilter() {
    switch (isSelected.value) {
      case 0:
        onRefresh();
        break;
      case 1: 
        if (isLoadingMore.value == false) {
          isMaxPage.value = false;
          pagination.value = 1;
          filteredOrdersList.clear();
        }
        fetchHistoryByStatus('completed');
        break;
      case 2:
        if (isLoadingMore.value == false) {
          isMaxPage.value = false;
          pagination.value = 1;
          filteredOrdersList.clear();
        }
        fetchHistoryByStatus('canceled');
        break;
    }
  }

  Future<void> postReview(int id) async {
    isLoading.value = true;
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token.toString()}',
      };
      var data = {
        'review': reviewDesc.value,
        'rating': reviewStar.value.toString(),
        'history_id': id.toString(),
      };
      final response = await http.post(
        Uri.parse("${url}/ratings/add"),
        headers: headers,
        body: data,
      );
      if (response.statusCode == 201) {
        customPopUp("Berhasil memberikan ulasan", successColor);
        clearRating();
        Get.back();
      } else {
        print(response.body);
        customPopUp("Error, Kode(${response.statusCode})", warningColor);
      }
    } catch (e) {
      customPopUp("Error, Kode(${e.toString()})", warningColor);
    } finally {
      isLoading.value = false;
    }
  }

  void clearRating() {
    reviewStar.value = 0.0;
    reviewDesc.value = '';
  }
  Future<void> onRefresh() async {
    isMaxPage.value = false;
    pagination.value = 1;
    filteredOrdersList.clear();
    ordersList.clear();
    isLoading.value = true;
    await getHistoryOrders();
    await getLaundries();
    isLoading.value = false;
  }



  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    onRefresh();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!isMaxPage.value) {
          pagination.value++;
          if (isSelected.value == 0) {
            getHistoryOrders();
          } else {
            applyFilter();
          }
          isLoadingMore.value = false;
        }
      }
    });
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
