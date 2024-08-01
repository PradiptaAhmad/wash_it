import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../../config.dart';
import '../../../infrastructure/theme/themes.dart';

class TransactionPageController extends GetxController {
  final count = 0.obs;
  var ordersList = {}.obs;
  var statusList = {}.obs;
  var isLoading = false.obs;
  GetStorage box = GetStorage();

  late final argument;

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

  Future<void> fetchDetailOrder() async {
    isLoading.value = true;
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(
        Uri.parse('$url/orders/detail?order_id=${argument[0]}'),
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

  Future<void> fetchStatusData() async {
    isLoading.value = true;
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(
        Uri.parse('$url/orders/status/last?order_id=${argument[0]}'),
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

  Future<void> createPayment() async {
    isLoading.value = true;
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var data = {
        'order_id': argument[0].toString(),
        'description': 'Bayar pesanan ${argument[0].toString()}',
      };

      final response = await http.post(
        Uri.parse("${url}/payments/create"),
        headers: headers,
        body: data,
      );

      if (response.statusCode == 201) {
        Get.snackbar('Success', 'Pembayaran berhasil dibuat',
            backgroundColor: successColor);
        print(json.decode(response.body));
        if (!await launchUrl(
            Uri.parse(json.decode(response.body)['checkout_link']))) {
          throw Exception(
              'Could not launch ${json.decode(response.body)['checkout_link']}');
        }
      } else {
        Get.snackbar('Error', '${response.statusCode}');
        print(response.body);
        print(data);
      }
    } catch (e) {
      Get.snackbar('Error Catch', e.toString());
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() async {
    super.onInit();
    argument = Get.arguments;
    await fetchDetailOrder();
    await fetchStatusData();
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
