import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:wash_it/infrastructure/navigation/routes.dart';
import 'package:wash_it/presentation/home_page/models/OrdersModel.dart';

import '../../../config.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;

  // Email and Password
  var email = ''.obs;
  var password = ''.obs;

  var ordersList = <OrdersModel>[].obs;
  final laundries = [].obs;
  final jenisList = [].obs;
  final userData = {}.obs;
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
        // Get.snackbar('Berhasil Fetch', '${response.statusCode}');
        final jsonResponse =
            jsonDecode(response.body)['order'] as List<dynamic>;
        List<OrdersModel> orders =
            jsonResponse.map((data) => OrdersModel.fromJson(data)).toList();
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

  Future<void> fetchUserData() async {
    try {
      isLoading.value = true;
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(
        Uri.parse('$url/users/me'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body)['user'];
        userData.value = jsonResponse; // Store raw JSON in userData
        isLoading.value = false;
      } else {
        Get.snackbar('Error', '${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getLaundries() async {
    try {
      isLoading.value = true;
      final url = ConfigEnvironments.getEnvironments()['url'];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var response = await http.get(
        Uri.parse('$url/admin/laundry/all'),
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

  Map<String, dynamic> detailtrasaction(int index, OrdersModel product) {
    return {
      'id': product.id,
      'index': index,
      'no_pemesanan': product.noPemesanan,
      'jenis_pemesanan': product.jenisPemesanan,
      'nama_pemesan': product.namaPemesan,
      'nomor_telepon': product.nomorTelepon,
      'alamat': product.alamat,
      'berat_laundry': product.beratLaundry,
      'total_harga': product.totalHarga,
      'payment_method': product.paymentMethod,
      'tanggal_pemesanan': product.tanggalPemesanan!
          .substring(0, product.tanggalPemesanan!.length - 3),
      'tanggal_pengambilan': product.tanggalPengambilan,
      'laundry_id': jenisList[int.parse(product.laundryId.toString()) - 1],
    };
  }

  void goToDetailTransactionPage(int index) {
    var product = ordersList[index];
    var productDetail = detailtrasaction(index, product);

    Get.toNamed(Routes.TRANSACTION_PAGE, arguments: productDetail);
  }

  void goToDetailRiwayatPage(int index) {
    var product = ordersList[index];
    var productDetail = detailtrasaction(index, product);

    Get.toNamed(Routes.HISTORY_DETAIL_PAGE, arguments: productDetail);
  }

  @override
  void onInit() {
    super.onInit();
    fetchOrdersData();
    getLaundries();
    fetchUserData();
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
