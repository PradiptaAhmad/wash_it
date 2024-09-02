import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchfield/searchfield.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';
import 'package:wash_it/presentation/address_page/controllers/address_page.controller.dart';

import '../../widgets/common/auth/input_form_widget.dart';
import '../../widgets/common/mainpage_appbar_widget.dart';
import '../order_page/widgets/search_dropdown_widget.dart';

class EditAddressPage extends GetView<AddressPageController> {
  EditAddressPage({
    Key? key,
    required this.editType,
    this.id,
    this.street,
    this.label,
    this.province,
    this.city,
    this.village,
    this.district,
    this.notes,
    this.postal,
    required this.isPrimary,
  }) : super(key: key);
  final String editType;
  final String? label, province, city, district, village, street, notes;
  final id, postal;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainpageAppbarWidget(
          title: editType == "add" ? "Tambah Alamat" : "Ubah Alamat",
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
                hintText: editType == 'edit' ? label : "Rumah",
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
                hintText: editType == 'edit' ? street : "Alamat lengkap",
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
                textController: controller.provinceTextController,
                titleText: "Provinsi",
                hintText:
                    editType == 'edit' ? province.toString() : "Jawa Tengah",
                readOnly: false,
                suggestions: controller.provinceList
                    .map((e) => SearchFieldListItem(e['province_name']))
                    .toList(),
                onSuggestionSelected: (newValue) {
                  controller.updateProvinceData(newValue!);
                  if (controller.province.value.isNotEmpty) {
                    controller.cityTextController.clear();
                    controller.districtTextController.clear();
                    controller.villageTextController.clear();
                    controller.postalCodeTextController.clear();
                    FocusScope.of(Get.overlayContext!).unfocus();
                  }
                  controller.getAllCities();
                }),
            Obx(() => _buildSearchField(
                controller: controller,
                textController: controller.cityTextController,
                titleText: "Kabupaten / Kota",
                hintText: editType == 'edit' ? city.toString() : "Kudus",
                readOnly: controller.province.isEmpty ? true : false,
                suggestions: controller.cityList
                    .map((e) => SearchFieldListItem(e))
                    .toList(),
                onSuggestionSelected: (newValue) {
                  controller.city.value = newValue!;
                  if (controller.city.value.isNotEmpty) {
                    controller.districtTextController.clear();
                    controller.villageTextController.clear();
                    controller.postalCodeTextController.clear();
                    FocusScope.of(Get.overlayContext!).unfocus();
                  }
                  controller.getAllDistricts();
                })),
            Obx(() => _buildSearchField(
                controller: controller,
                textController: controller.districtTextController,
                titleText: "Kecamatan",
                hintText: editType == 'edit' ? district.toString() : "Gebog",
                readOnly: controller.city.isEmpty ? true : false,
                suggestions: controller.districtList
                    .map((e) => SearchFieldListItem(e))
                    .toList(),
                onSuggestionSelected: (newValue) {
                  controller.district.value = newValue!;
                  if (controller.district.value.isNotEmpty) {
                    controller.villageTextController.clear();
                    controller.postalCodeTextController.clear();
                    FocusScope.of(Get.overlayContext!).unfocus();
                  }
                  controller.getAllVillages();
                })),
            Obx(() => _buildSearchField(
                controller: controller,
                textController: controller.villageTextController,
                titleText: "Kelurahan",
                hintText: editType == 'edit' ? village.toString() : "Besito",
                readOnly: controller.district.isEmpty ? true : false,
                suggestions: controller.villageList
                    .map((e) => SearchFieldListItem(e))
                    .toList(),
                onSuggestionSelected: (newValue) {
                  controller.village.value = newValue!;
                  if (controller.village.value.isNotEmpty) {
                    controller.postalCodeTextController.clear();
                    FocusScope.of(Get.overlayContext!).unfocus();
                  }
                  controller.getAllPostalCode();
                })),
            Obx(() => _buildSearchField(
                controller: controller,
                textController: controller.postalCodeTextController,
                titleText: "Kode Pos",
                hintText: editType == 'edit' ? postal.toString() : "59361",
                readOnly: controller.village.isEmpty ? true : false,
                suggestions: controller.postalList
                    .map((e) => SearchFieldListItem(e.toString()))
                    .toList(),
                onSuggestionSelected: (newValue) {
                  controller.postalCode.value = int.parse(newValue!);
                  if (controller.postalCode.value != 0) {
                    FocusScope.of(Get.overlayContext!).unfocus();
                  }
                })),
            InputFormWidget(
                title: "Catatan (Opsional)",
                hintText: editType == 'edit' && editType.isEmpty
                    ? notes.toString()
                    : "(contoh) Rumah warna biru",
                validator: (value) {
                  controller.notes.value = value;
                  return null;
                }),
            SizedBox(height: 20),
            InkWell(
              onTap: () async {
                controller.isLoading.value = true;
                switch (editType) {
                  case 'add':
                    await controller.postAddressUser();
                    Get.back();
                    break;
                  case 'edit':
                    await controller.updateAddress(
                      id: id,
                      type: controller.label.value.isEmpty
                          ? label.toString()
                          : controller.label.value,
                      notes: controller.notes.value.isEmpty
                          ? notes.toString()
                          : controller.notes.value,
                      street: controller.address.value.isEmpty
                          ? street.toString()
                          : controller.address.value,
                      village: controller.village.value.isEmpty
                          ? village.toString()
                          : controller.village.value,
                      district: controller.district.value.isEmpty
                          ? district.toString()
                          : controller.district.value,
                      city: controller.city.value.isEmpty
                          ? city.toString()
                          : controller.city.value,
                      province: controller.province.value.isEmpty
                          ? province.toString()
                          : controller.province.value,
                      postalCode: controller.postalCode.value == 0
                          ? int.parse(postal)
                          : controller.postalCode.value,
                      isPrimary: isPrimary,
                    );
                    Get.back();
                    break;
                  default:
                }
                controller.isLoading.value = false;
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
                            child: Text(
                                editType == "add"
                                    ? "Tambah Alamat"
                                    : "Ubah Alamat",
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
  String? Function(String?)? validator,
  TextEditingController? textController,
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
        validator: validator,
        controller: textController,
        suggestions: suggestions,
        onSuggestionSelected: onSuggestionSelected,
      ),
    ],
  );
}
