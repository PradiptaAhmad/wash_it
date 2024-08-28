import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wash_it/infrastructure/navigation/routes.dart';
import 'package:wash_it/presentation/address_page/edit_address_page.dart';
import 'package:wash_it/presentation/order_page/controllers/order_page.controller.dart';
import 'package:wash_it/widgets/common/button_widget.dart';

import '../../../infrastructure/theme/themes.dart';
import '../../../widgets/common/main_container_widget.dart';

Future addressSelectWidget(BuildContext context, OrderController controller) {
  return showModalBottomSheet(
    context: context,
    enableDrag: true,
    isDismissible: true,
    // scrollControlDisabledMaxHeightRatio: 0.45,
    sheetAnimationStyle: AnimationStyle(
      duration: Durations.medium1,
      curve: Curves.easeInOut,
    ),
    backgroundColor: primaryColor,
    // isScrollControlled: true,
    builder: (context) {
      final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
      return Padding(
        padding: EdgeInsets.only(bottom: keyboardHeight),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: Icon(
                      Icons.close_rounded,
                      color: darkGrey,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text("Pilih Alamat", style: tsBodySmallSemibold(black)),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                child: Column(
                  children: [
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: controller.addressList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var address = controller.addressList[index];
                        return Obx(
                          () => InkWell(
                            onTap: () {
                              controller.selectedAddress.value = index;
                              controller.addressNum.value = address['id'];
                              controller.address.value =
                                  "${address['street']}, ${address['village']}, ${address['district']}, ${address['city']}, ${address['province']}, ${address['postal_code']}";
                            },
                            child: MainContainerWidget(
                              border: Border.all(
                                  color:
                                      controller.selectedAddress.value == index
                                          ? secondaryColor
                                          : lightGrey.withOpacity(0.5),
                                  width: 2),
                              padding: const EdgeInsets.all(15),
                              margin: EdgeInsets.only(right: 10),
                              width: 200,
                              height: 100,
                              childs: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${address['type'] + address['id'].toString()}",
                                    style: tsBodySmallMedium(black),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "${address['street']}, ${address['village']}, ${address['district']}, ${address['city']}, ${address['province']}, ${address['postal_code']}",
                                    style: tsLabelLargeSemibold(darkGrey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        Get.toNamed(Routes.EDIT_ADDRESS_PAGE)?.then((value) {
                          if (value == null) {
                            controller.getAddressUser();
                          }
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: screenHeight(context) * 0.05,
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          'Tambah Alamat',
                          style: tsLabelLargeSemibold(primaryColor),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
