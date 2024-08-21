import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchfield/searchfield.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';
import 'package:wash_it/presentation/address_page/controllers/address_page.controller.dart';

import '../../widgets/common/auth/input_form_widget.dart';
import '../../widgets/common/mainpage_appbar_widget.dart';
import '../order_page/widgets/search_dropdown_widget.dart';

class AddAddressPage extends GetView<AddressPageController> {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainpageAppbarWidget(
          title: "Tambah Alamat",
          onPressed: () {
            controller.clearForm();
            Get.back();
          }),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          children: [
            InputFormWidget(
                title: "Label",
                hintText: "Label",
                validator: (value) {
                  if (value.isEmpty) {
                    return "Nama alamat tidak boleh kosong";
                  } else {
                    controller.label.value = value;
                  }
                  return null;
                }),
            InputFormWidget(
                title: "Detail Alamat",
                hintText: "Alamat Lengkap",
                validator: (value) {
                  if (value.isEmpty) {
                    return "Detail alamat tidak boleh kosong";
                  } else {
                    controller.address.value = value;
                  }
                  return null;
                }),
            _buildSearchField(
                controller: controller,
                titleText: "Provinsi",
                hintText: "Jawa Tengah",
                readOnly: false,
                suggestions: controller.provinceList
                    .map((e) => SearchFieldListItem(e['province_name']))
                    .toList(),
                onSuggestionSelected: (newValue) {
                  controller.updateProvinceData(newValue!);
                  controller.getAllCities();
                }),
            Obx(() => _buildSearchField(
                controller: controller,
                titleText: "Kabupaten / Kota",
                hintText: "Kudus",
                readOnly: controller.province.isEmpty ? true : false,
                suggestions: controller.cityList
                    .map((e) => SearchFieldListItem(e))
                    .toList(),
                onSuggestionSelected: (newValue) {
                  controller.city.value = newValue!;
                  controller.getAllDistricts();
                })),
            Obx(() => _buildSearchField(
                controller: controller,
                titleText: "Kecamatan",
                hintText: "Gebog",
                readOnly: controller.city.isEmpty ? true : false,
                suggestions: controller.districtList
                    .map((e) => SearchFieldListItem(e))
                    .toList(),
                onSuggestionSelected: (newValue) {
                  controller.district.value = newValue!;
                  controller.getAllVillages();
                })),
            Obx(() => _buildSearchField(
                controller: controller,
                titleText: "Kelurahan",
                hintText: "Besito",
                readOnly: controller.district.isEmpty ? true : false,
                suggestions: controller.villageList
                    .map((e) => SearchFieldListItem(e))
                    .toList(),
                onSuggestionSelected: (newValue) {
                  controller.village.value = newValue!;
                  controller.getAllPostalCode();
                })),
            Obx(() => _buildSearchField(
                controller: controller,
                titleText: "Kode Pos",
                hintText: "59361",
                readOnly: controller.village.isEmpty ? true : false,
                suggestions: controller.postalList
                    .map((e) => SearchFieldListItem(e.toString()))
                    .toList(),
                onSuggestionSelected: (newValue) {
                  controller.postalCode.value = int.parse(newValue!);
                })),
            // InputFormWidget(
            //     title: "Catatan (Opsional)",
            //     hintText: "Sebelah toko baju",
            //     validator: (value) {
            //       controller.province.value = value;
            //       return null;
            //     }),
            SizedBox(height: 20),
            InkWell(
              onTap: () async {
                controller.isLoading.value = true;
                await controller.postAddressUser();
                controller.isLoading.value = false;
                Get.back();
              },
              splashColor: Colors.transparent,
              child: Obx(() {
                return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 50,
                    child: controller.isLoading.value
                        ? Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Transform.scale(
                                scale: 0.5,
                                child: CircularProgressIndicator(
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          )
                        : Center(
                            child: Text("Tambahkan Alamat",
                                style: tsBodySmallSemibold(primaryColor)),
                          ));
              }),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

Widget _buildSearchField({
  required AddressPageController controller,
  required String titleText,
  required String hintText,
  required suggestions,
  required void Function(String?) onSuggestionSelected,
  required bool readOnly,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 10),
      Text(
        titleText,
        style: tsBodySmallMedium(black),
      ),
      SizedBox(height: 10),
      SearchDropdownWidget(
        readOnly: readOnly,
        hintText: hintText,
        suggestions: suggestions,
        onSuggestionSelected: onSuggestionSelected,
      ),
    ],
  );
}
