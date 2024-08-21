import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wash_it/presentation/address_page/controllers/address_page.controller.dart';

import '../../../../infrastructure/theme/themes.dart';

Future moreButtonPopUp(
    BuildContext context, AddressPageController controller, dynamic address) {
  return showModalBottomSheet(
    context: context,
    isDismissible: true,
    builder: (context) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.15,
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: Icon(
                      Icons.close_rounded,
                      color: black,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text("Opsi lebih", style: tsBodyMediumMedium(black)),
                ],
              ),
              SizedBox(height: 15),
              InkWell(
                onTap: () => controller.updateAddress(
                  id: int.parse(address['id'].toString()),
                  type: address['type'].toString(),
                  street: address['street'].toString(),
                  village: address['village'].toString(),
                  district: address['district'].toString(),
                  city: address['city'].toString(),
                  province: address['province'].toString(),
                  postalCode: int.parse(address['postal_code'].toString()),
                  notes: address['notes'].toString(),
                  isPrimary: true,
                ),
                splashColor: Colors.transparent,
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  height: 28,
                  child: Text("Jadikan alamat utama",
                      style: tsBodySmallMedium(black)),
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  print("object");
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Hapus alamat"),
                      content:
                          Text("Apakah anda yakin ingin menghapus alamat ini?"),
                      actions: [
                        TextButton(
                          onPressed: () => Get.back(),
                          child: Text("Batal"),
                        ),
                        TextButton(
                          onPressed: () =>
                              controller.deleteAddresss(address['id']),
                          child: Text("Hapus"),
                        ),
                      ],
                    ),
                  );
                },
                splashColor: Colors.transparent,
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  height: 28,
                  child: Text("Hapus alamat",
                      style: tsBodySmallMedium(warningColor)),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
