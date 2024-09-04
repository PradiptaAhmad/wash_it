import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';

import '../../../config.dart';
import 'package:http/http.dart' as http;

class OrderController extends GetxController {
  final count = 0.obs;
  var currentStep = 0.obs;
  var ordername = ''.obs;
  var phonenumber = ''.obs;
  var canContinue = false.obs;
  var isSelected = false.obs;
  var selectedAddress = 0.obs;
  var paymentList = ['Tunai', 'Non Tunai'].obs;
  var addressList = [].obs;
  var ordertype = ''.obs;
  var address = ''.obs;
  var addressNum = 0.obs;
  var catatan = ''.obs;
  var payment = ''.obs;
  var pickupdate = ''.obs;
  var laundryIndex = 0.obs;
  var laundryName = ''.obs;
  final nameTextController = TextEditingController();
  final phoneTextEditingController = TextEditingController();
  final addressTextEditingController = TextEditingController();
  var isLoading = false.obs;
  final userData = {}.obs;
  final laundries = [].obs;
  final jenisList = [].obs;
  GetStorage box = GetStorage();
  late final argument;

  Future<void> createOrder() async {
    isLoading.value = true;
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');
      int laundryId = laundries[laundryIndex.value]['id'];

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token.toString()}',
      };

      var data = {
        'nama_pemesan': ordername.value,
        'nomor_telepon': phonenumber.value,
        'jenis_pemesanan': argument,
        'address_id': addressNum.value.toString(),
        'tanggal_pengambilan': pickupdate.value,
        'laundry_id': laundryId.toString(),
        'metode_pembayaran': payment.value == 'Tunai' ? 'tunai' : 'non_tunai',
        'catatan': catatan.value,
      };
      final response = await http.post(
        Uri.parse("${url}/orders/new"),
        headers: headers,
        body: data,
      );

      if (response.statusCode == 201) {
        Get.snackbar('Success', 'Order has been created',
            backgroundColor: successColor);
        currentStep.value = 0;
        // final jsonResponse = jsonDecode(response.body)['user'];
      } else {
        Get.snackbar('Error', '${response.statusCode}');
        print(response.body);
        print(data);
      }
    } catch (e) {
      Get.snackbar('Error catch', e.toString());
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchUserData() async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token.toString()}',
      };

      final response = await http.get(
        Uri.parse('$url/users/me'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body)['user'];
        userData.value = jsonResponse;
      } else {
        Get.snackbar('Error', '${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error catch', e.toString());
    }
  }

  Future<void> getLaundries() async {
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

      laundries.forEach((element) {
        jenisList.add(element['nama_laundry']);
      });
    } else {
      Get.snackbar('Error', '${response.statusCode}');
    }
  }

  Future<void> getAddressUser() async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token.toString()}',
      };
      final response = await http.get(
        Uri.parse("${url}/addresses/get"),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body)['data'];
        addressList.value = jsonResponse;
      } else {
        Get.snackbar('Error', '${response.statusCode}');
        print(response.body);
      }
    } catch (e) {
      print(e);
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

  void pageChangedPlus() {
    if (currentStep.value < 3) {
      currentStep.value++;
    }
  }

  void pageChangedMin() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  void clearAll() {
    count.value = 0;
    currentStep.value = 0;
    ordername.value = '';
    phonenumber.value = '';
    canContinue.value = false;
    isSelected.value = false;
    selectedAddress.value = 0;
    paymentList.value = ['Tunai', 'Non Tunai'];
    addressList.value = [];
    ordertype.value = '';
    address.value = '';
    addressNum.value = 0;
    catatan.value = '';
    payment.value = '';
    pickupdate.value = '';
    laundryIndex.value = 0;
    laundryName.value = '';
    isLoading = false.obs;
    userData.value = {}.obs;
    laundries.value = [].obs;
    jenisList.value = [].obs;
    nameTextController.clear();
    phoneTextEditingController.clear();
    addressTextEditingController.clear();
  }

  @override
  void onInit() async {
    super.onInit();
    argument = Get.arguments;
    isLoading.value = true;
    await fetchUserData();
    await getLaundries();
    await getAddressUser();
    isLoading.value = false;
    address =
        "${addressList[0]['street']}, ${addressList[0]['village']}, ${addressList[0]['district']}, ${addressList[0]['city']}, ${addressList[0]['province']}, ${addressList[0]['postal_code']}"
            .obs;
    addressNum.value = addressList[0]['id'];
    print(address);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    super.dispose();
    nameTextController.dispose();
    phoneTextEditingController.dispose();
    addressTextEditingController.dispose();
  }

  @override
  void onClose() {
    super.onClose();
    clearAll();
  }
}
