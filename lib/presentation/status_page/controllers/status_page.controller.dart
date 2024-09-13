import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:wash_it/infrastructure/theme/themes.dart';
import 'package:wash_it/widgets/popup/custom_pop_up.dart';
import '../../../config.dart';

class StatusPageController extends GetxController {
  final count = 0.obs;
  var isLoading = false.obs;

  //Status Page Controller//
  var ordersList = [].obs;
  var filteredOrdersList = [].obs;
  var selectedFilter = 0.obs;
  var statusSelectedFilterName = ''.obs;
  var typeSelectedFilterName = ''.obs;
  var paginate = 1.obs;
  var isMaxPage = false.obs;
  var isLoadingMore = false.obs;
  var scrollController = ScrollController();
  GetStorage box = GetStorage();

  Future<void> fetchOrdersData() async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');
      final response = await http.get(
        Uri.parse('$url/orders/all?page=${paginate.value}'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        if (List.from(jsonDecode(response.body)['order']).isEmpty) {
          isMaxPage.value = true;
        }
        ordersList.addAll(jsonDecode(response.body)['order']);
      } else {
        customPopUp("Error, Kode(${response.statusCode})", warningColor);
      }
    } catch (e) {
      customPopUp("Error, Kode(${e.toString()})", warningColor);
    }
  }

  Future<void> fetchFilteredOrder(String filter, String mode) async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');
      final response = await http.get(
        mode == "status"
            ? Uri.parse(
                '$url/orders/filter/status?status_code=${filter}&page=${paginate.value}')
            : mode == "service"
                ? Uri.parse(
                    '$url/orders/filter/service?service=${filter}&page=${paginate.value}')
                : Uri.parse('$url/orders/all?page${paginate.value}'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body)['data'];
        if (jsonResponse.isEmpty) {
          isMaxPage.value = true;
        }
        filteredOrdersList.addAll(jsonResponse);
        print(jsonResponse);
      } else {
        customPopUp("Error, Kode(${response.statusCode})", warningColor);
      }
    } catch (e) {
      customPopUp("Error, Kode(${e.toString()})", warningColor);
    }
  }

  void applyFilter(String mode) async {
    if (mode == 'paginate') {
      isLoadingMore.value = true;
      paginate.value++;
    } else {
      isLoading.value = true;
      paginate.value = 1;
      isMaxPage.value = false;
      filteredOrdersList.clear();
      ordersList.clear();
    }
    if (selectedFilter.value == 0) {
      await fetchOrdersData();
    } else if (selectedFilter.value == 1) {
      await fetchFilteredOrder("1", 'status');
    } else if (selectedFilter.value == 2) {
      await fetchFilteredOrder("2", 'status');
    } else if (selectedFilter.value == 3) {
      await fetchFilteredOrder("3", 'status');
    } else if (selectedFilter.value == 4) {
      await fetchFilteredOrder("4", 'status');
    } else if (selectedFilter.value == 5) {
      await fetchFilteredOrder("5", 'status');
    } else if (selectedFilter.value == 6) {
      await fetchFilteredOrder("antar_jemput", 'service');
    } else if (selectedFilter.value == 7) {
      await fetchFilteredOrder("antar_mandiri", 'service');
    }

    if (mode == 'paginate') {
      isLoadingMore.value = false;
    } else {
      isLoading.value = false;
    }
  }

  void onRefresh() async {
    if (selectedFilter == 0) {
      isLoading.value = true;
      paginate.value = 1;
      isMaxPage.value = false;
      ordersList.clear();
      filteredOrdersList.clear();
      await fetchOrdersData();
      isLoading.value = false;
    } else {
      applyFilter('refresh');
    }
  }

  @override
  void onInit() {
    super.onInit();
    onRefresh();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        applyFilter('paginate');
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
  }

  void increment() => count.value++;
}
