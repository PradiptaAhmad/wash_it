import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:wash_it/widgets/popup/custom_pop_up.dart';
import '../../../config.dart';
import '../../../infrastructure/theme/themes.dart';

class TransactionPageController extends GetxController {
  final count = 0.obs;
  var isLoading = false.obs;
  var ordersList = {}.obs;
  var statusList = {}.obs;
  var paymentList = {}.obs;
  var displayText = ''.obs;
  var reviewDesc = ''.obs;
  var reviewStar = 0.0.obs;
  GetStorage box = GetStorage();
  late final argument;

  Future<void> getDetailOrder() async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http.get(
        Uri.parse(argument[1] == 'histories'
            ? '$url/histories/detail?history_id=${argument[0]}'
            : '$url/orders/detail?order_id=${argument[0]}'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        ordersList.value = argument[1] == "histories"
            ? jsonDecode(response.body)['data']
            : jsonDecode(response.body)['order'];
      } else {
        customPopUp("Error, Kode(${response.statusCode})", warningColor);
      }
    } catch (e) {
      customPopUp("Error, Kode(${e.toString()})", warningColor);
    }
  }

  Future<void> getStatusProgress() async {
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
        statusList.value = jsonDecode(response.body)['order_status'];
      } else {
        customPopUp("Error, Kode:${response.statusCode}", warningColor);
      }
    } catch (e) {
      customPopUp("Error, Kode(${e.toString()})", warningColor);
    }
  }

  Future<void> putCompleteOrder() async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var data = {
        'order_id': argument[0].toString(),
      };
      final response = await http.put(
        Uri.parse("${url}/orders/complete"),
        headers: headers,
        body: data,
      );
      if (response.statusCode == 200) {
        Get.snackbar('Berhasil', 'Pesanan telah selesai',
            backgroundColor: warningColor);
        Get.back();
      } else if (response.statusCode == 400) {
        Get.snackbar('Error', 'Pembayaran sudah selesai',
            backgroundColor: warningColor);
      } else {
        customPopUp("Failed, Kode(${response.statusCode})", warningColor);
      }
    } catch (e) {
      customPopUp("Error, Kode(${e.toString()})", warningColor);
    }
  }

  Future<void> putOrderCancel() async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token.toString()}',
      };
      final response = await http.put(
        Uri.parse("${url}/orders/cancel?order_id=${argument[0]}"),
        headers: headers,
      );
      if (response.statusCode == 200) {
        customPopUp("Order telah berhasil di cancel", successColor);
        Get.back();
        Get.back();
      } else {
        customPopUp("Error, Kode(${response.statusCode})", warningColor);
      }
    } catch (e) {
      customPopUp("Error, Kode(${e.toString()})", warningColor);
    }
  }

  Future<void> postReview() async {
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
        'history_id': argument[0].toString(),
      };
      final response = await http.post(
        Uri.parse("${url}/ratings/add"),
        headers: headers,
        body: data,
      );
      if (response.statusCode == 201) {
        customPopUp("Berhasil memberikan ulasan", successColor);
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

  Future<void> fetchTransaction() async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token.toString()}',
      };
      final response = await http.get(
        Uri.parse("${url}/transaction/get?id=${argument[0]}"),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body)['transaction'];
        paymentList.value = jsonResponse;
      } else if (response.statusCode == 404) {
      } else {
        print(response.body);
        customPopUp("Error, Kode(${response.statusCode})", warningColor);
      }
    } catch (e) {
      customPopUp("Error, gagal untuk mengambil data transaksi", warningColor);
    }
  }

  Future<void> buttonTitle() async {
    if (argument[1] == 'order') {
      if (ordersList['metode_pembayaran'] == "non_tunai" &&
          statusList['status_code'] > 1) {
        displayText.value = 'Bayar sekarang';
      }
      if (statusList['status_code'] == 1) {
        displayText.value = 'Batalkan Pesanan';
      }
      if (ordersList['status'] == "completed") {
        displayText.value = 'Selesai';
      }
    }
    if (argument[1] == 'histories') {
      displayText.value = 'Beri ulasan';
    }
  }

  void onRefresh() async {
    isLoading.value = true;
    await getDetailOrder();
    if (argument[1] == 'histories') {
      if (ordersList['status'] == 'canceled') {
        statusList.value = {
          'status_code': 1,
          'status': 'success',
          'status_description': 'Pesanan Dibatalkan'
        };
      } else {
        statusList.value = {
          'status_code': 5,
          'status': 'success',
          'status_description': 'Pesanan Selesai'
        };
      }
      print(statusList);
    } else {
      await getStatusProgress();
    }
    await buttonTitle();
    await fetchTransaction();
    isLoading.value = false;
  }

  @override
  void onInit() async {
    super.onInit();
    argument = Get.arguments;
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
