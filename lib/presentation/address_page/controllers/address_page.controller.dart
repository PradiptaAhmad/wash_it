import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';
import 'package:wash_it/widgets/popup/custom_pop_up.dart';

import '../../../config.dart';

class AddressPageController extends GetxController {

  final count = 0.obs;
  var isLoading = false.obs;
  var addressList = [].obs;
  var provinceList = [].obs;
  var cityList = [].obs;
  var districtList = [].obs;
  var villageList = [].obs;
  var postalList = [].obs;
  var provinceCode = 0.obs;
  var label = ''.obs;
  var notes = ''.obs;
  var address = ''.obs;
  var village = ''.obs;
  var district = ''.obs;
  var city = ''.obs;
  var province = ''.obs;
  var postalCode = 0.obs;
  GetStorage box = GetStorage();

  var provinceTextController = TextEditingController();
  var cityTextController = TextEditingController();
  var districtTextController = TextEditingController();
  var villageTextController = TextEditingController();
  var postalCodeTextController = TextEditingController();
  

  Future<void> getAddressUser() async {
    isLoading.value = true;
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
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteAddresss(int id) async {
    isLoading.value = true;
    Get.back();
    Get.back();
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token.toString()}',
      };
      final response = await http.delete(
        Uri.parse("${url}/addresses/delete?id=${id}"),
        headers: headers,
      );
      if (response.statusCode == 200) {
        customPopUp("Berhasil Meenghapus Alamat", successColor);
        await getAddressUser();
      } else {
        Get.snackbar('Error', '${response.statusCode}');
        print(response.body);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getAllProvince() async {
    isLoading.value = true;
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token.toString()}',
      };
      final response = await http.get(
        Uri.parse("${url}/addresses/get/provinces"),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body)['data'];
        provinceList.value = jsonResponse;
      } else {
        Get.snackbar('Error', '${response.statusCode}');
        print(response.body);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getAllCities() async {
    isLoading.value = true;
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token.toString()}',
      };
      final response = await http.get(
        Uri.parse(
            "${url}/addresses/get/cities?province_code=${provinceCode.value}"),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body)['data'];
        cityList.value = jsonResponse;
      } else {
        Get.snackbar('Error', '${response.statusCode}');
        print(response.body);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getAllDistricts() async {
    isLoading.value = true;
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token.toString()}',
      };
      final response = await http.get(
        Uri.parse("${url}/addresses/get/districts?city=${city.value}"),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body)['data'];
        districtList.value = jsonResponse;
      } else {
        Get.snackbar('Error', '${response.statusCode}');
        print(response.body);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getAllVillages() async {
    isLoading.value = true;
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token.toString()}',
      };
      final response = await http.get(
        Uri.parse("${url}/addresses/get/villages?district=${district.value}"),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body)['data'];
        villageList.value = jsonResponse;
      } else {
        Get.snackbar('Error', '${response.statusCode}');
        print(response.body);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getAllPostalCode() async {
    isLoading.value = true;
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token.toString()}',
      };
      final response = await http.get(
        Uri.parse(
            "${url}/addresses/get/postal-code?city=${city.value}&village=${village.value}"),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body)['data'];
        postalList.value = jsonResponse;
      } else {
        Get.snackbar('Error', '${response.statusCode}');
        print(response.body);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> postAddressUser() async {
    isLoading.value = true;
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token.toString()}',
      };

      var data = {
        'province': province.value,
        'city': city.value,
        'district': district.value,
        'village': village.value,
        'postal_code': postalCode.value.toString(),
        'street': address.value,
        'type': label.value,
        'notes': notes.value,
        'is_primary': 0.toString(),
      };

      final response = await http.post(Uri.parse("${url}/addresses/add"),
          headers: headers, body: data);

      if (response.statusCode == 201) {
        customPopUp("Berhasil menambah alamat", successColor);
        await getAddressUser();
      } else {
        Get.snackbar('Error', '${response.statusCode}');
        print(response.body);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void updateProvinceData(String newValue) async {
    province.value = newValue;
    provinceList.forEach((province) {
      if (province['province_name'] == newValue) {
        provinceCode.value = province['province_code'];
      }
    });
  }

  Future<void> updateAddress(
      {required int id,
      required String type,
      required String notes,
      required String street,
      required String village,
      required String district,
      required String city,
      required String province,
      required int postalCode,
      required bool isPrimary}) async {
    isLoading.value = true;
    Get.back();
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token.toString()}',
      };

      var body = {
        'id': id.toString(),
        'type': type,
        'notes': notes,
        'street': street,
        'village': village,
        'district': district,
        'city': city,
        'province': province,
        'postal_code': postalCode.toString(),
        'is_primary': isPrimary == true ? "1" : "0",
      };
      final response = await http.put(
        Uri.parse("${url}/addresses/edit"),
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        customPopUp('Berhasil mengubah menjadi alamat utama', successColor);
        await getAddressUser();
      } else {
        print(response.body);
        customPopUp('Gagal edit alamat', warningColor);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void clearForm() {
    label.value = '';
    notes.value = '';
    address.value = '';
    village.value = '';
    district.value = '';
    city.value = '';
    province.value = '';
    postalCode.value = 0;
    provinceCode.value = 0;
    cityList.clear();
    districtList.clear();
    villageList.clear();
    postalList.clear();
  }

  @override
  void onInit() {
    super.onInit();
    getAddressUser();
    getAllProvince();
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
