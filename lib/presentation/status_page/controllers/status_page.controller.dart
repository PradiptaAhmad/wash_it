import 'dart:convert';
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
  GetStorage box = GetStorage();

  Future<void> fetchOrdersData() async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');
      final response = await http.get(
        Uri.parse('$url/orders/all'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        ordersList.value = jsonDecode(response.body)['order'];
      } else {
        customPopUp("Error, Kode(${response.statusCode})", warningColor);
      }
    } catch (e) {
      customPopUp("Error, Kode(${e.toString()})", warningColor);
    }
  }

  void applyFilter() {
    final filters = [
      null,
      (order) => order['status'] == "Pesanan Telah Dibuat",
      (order) => order['status'] == "Menunggu Penjemputan",
      (order) => order['status'] == "Sedang Diproses",
      (order) => order['status'] == "Belum Dibayar",
      (order) => order['status'] == "Selesai",
      (order) => order['jenis_pemesanan'] == "antar_jemput",
      (order) => order['jenis_pemesanan'] == "antar_mandiri"
    ];

    filteredOrdersList.value = ordersList
        .where(filters[selectedFilter.value] ?? (order) => true)
        .toList();
  }

  void onRefresh() async {
    isLoading.value = true;
    await fetchOrdersData();
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
