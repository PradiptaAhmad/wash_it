import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../config.dart';
import '../../home_page/models/OrdersModel.dart';

class OrderAntarJemputController extends GetxController {
  var tipeLaundry = ''.obs;
  var catatan = ''.obs;
  var jadwalPengambilan = Rx<DateTime?>(null);

  final count = 0.obs;
  var ordersList = <OrdersModel>[].obs;
  var isLoading = false.obs;
  GetStorage box = GetStorage();

  get http => null;

  Future<void> fetchOrdersData() async {
    try {
      isLoading.value = true;
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
        final jsonResponse = jsonDecode(response.body)['order'] as List<dynamic>;
        List<OrdersModel> orders = jsonResponse.map((data) => OrdersModel.fromJson(data)).toList();
        ordersList.value = orders;
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

  void setTipeLaundry(String tipe) {
    tipeLaundry.value = tipe;
  }

  void setCatatan(String note) {
    catatan.value = note;
  }

  void setJadwalPengambilan(DateTime jadwal) {
    jadwalPengambilan.value = jadwal;
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
}