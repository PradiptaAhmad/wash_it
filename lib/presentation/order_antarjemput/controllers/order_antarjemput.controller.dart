import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wash_it/infrastructure/navigation/routes.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';

import '../../../config.dart';
import 'package:http/http.dart' as http;

class OrderAntarJemputController extends GetxController {
  final count = 0.obs;
  var ordername = ''.obs;
  var phonenumber = ''.obs;
  var ordertype = ''.obs;
  var address = ''.obs;
  var pickupdate = ''.obs;
  var laundryIndex = 0.obs;

  var isLoading = true.obs;
  final userData = {}.obs;
  final laundries = [].obs;

  final jenisList = [].obs;

  GetStorage box = GetStorage();

  get ordersList => null;

  Future<void> createOrder() async {
    isLoading.value = true;
    final url = ConfigEnvironments.getEnvironments()["url"];
    final token = box.read('token');
    int laundryId = laundries[laundryIndex.value]['id'];

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var data = {
      'nama_pemesan': ordername.value,
      'nomor_telepon': phonenumber.value,
      'jenis_pemesanan': 'antar_jemput',
      'alamat': address.value,
      'tanggal_pengambilan': pickupdate.value,
      'laundry_id': laundryId.toString(),
    };
    final response = await http.post(
      Uri.parse("${url}/orders/new"),
      headers: headers,
      body: data,
    );

    if (response.statusCode == 201) {
      Get.snackbar('Success', 'Order has been created',
          backgroundColor: successColor);
      Get.toNamed(Routes.NAVBAR);

      print(data);
      // final jsonResponse = jsonDecode(response.body)['user'];
    } else {
      Get.snackbar('Error', '${response.statusCode}');
      print(response.body);
    }
    isLoading.value = false;
  }

  void updateOrderName(String newOrderName) {
    ordername.value = newOrderName;
  }

  void updatePhoneNumber(String newPhoneNumber) {
    phonenumber.value = newPhoneNumber;
  }

  void updateOrderType(String newOrderType) {
    ordertype.value = newOrderType;
  }

  void updateAddress(String newAddress) {
    address.value = newAddress;
  }

  void updatePickupDate(newPickupDate) {
    pickupdate.value = newPickupDate.toString();
  }

  Future<void> getLaundries() async {
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

      laundries.forEach((element) {
        jenisList.add(element['nama_laundry']);
      });
    } else {
      Get.snackbar('Error', '${response.statusCode}');
    }
  }

  Future<void> getIdLaundries(String name) async {
    for (int i = 0; i < laundries.length; i++) {
      if (laundries[i]['nama_laundry'] == name) {
        laundryIndex.value = i;
        break;
      }
    }
  }

  @override
  void onInit() {
    getLaundries();
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
