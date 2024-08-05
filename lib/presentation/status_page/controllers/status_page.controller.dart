import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../../config.dart';

class StatusPageController extends GetxController {
  final count = 0.obs;
  var ordersList = [].obs;
  var laundries = [].obs;
  var jenisList = [].obs;
  var statusList = {}.obs;
  var selectedFilter = 0.obs;
  var statusSelectedFilterName = ''.obs;
  var isLoading = false.obs;
  GetStorage box = GetStorage();

  Future<void> fetchOrdersData() async {
    isLoading.value = true;
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

  Future<void> fetchStatusData(orderId) async {
    isLoading.value = true;
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(
        Uri.parse('$url/orders/status/last?order_id=${orderId}'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body)['order_status'];
        statusList.value = jsonResponse;
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
    isLoading = true.obs;
    fetchOrdersData();
    getLaundries();
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
