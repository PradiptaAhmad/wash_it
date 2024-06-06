import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:wash_it/presentation/home_page/models/OrdersModel.dart';
import '../../../config.dart';

class TransactionPageController extends GetxController {
  final count = 0.obs;
  var ordersList = <OrdersModel>[].obs;
  var isLoading = false.obs;
  GetStorage box = GetStorage();

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

  @override
  void onInit() {
    super.onInit();
    fetchOrdersData();
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
