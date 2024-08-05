import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../../config.dart';
import '../../../infrastructure/theme/themes.dart';

class PaymentPageController extends GetxController {
  // Observable selectedMethod
  var selectedMethod = 0.obs;
  var isLoading = false.obs;
  var paymentList = {}.obs;
  late final argument;

  Future<void> createPayment() async {
    isLoading.value = true;
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      GetStorage box = GetStorage();
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
        print(json.decode(response.body));
        if (!await launchUrl(
            Uri.parse(json.decode(response.body)['checkout_link']))) {
          throw Exception(
              'Could not launch ${json.decode(response.body)['checkout_link']}');
        }
      } else if (response.statusCode == 400) {
        Get.snackbar('Error', 'Pembayaran sudah selesai',
            backgroundColor: primaryColor);
        print(response.body);
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

  Future<void> fetchPaymentDetail() async {
    isLoading.value = true;
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      GetStorage box = GetStorage();
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
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
        Get.snackbar('Error', '${response.statusCode}');
        print(response.statusCode);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    argument = Get.arguments;
  }

  @override
  void onReady() {
    super.onReady();
    fetchPaymentDetail();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Method to update the selected method
  void selectMethod(int methodIndex) {
    selectedMethod.value = methodIndex;
  }
}
