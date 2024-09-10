import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';
import 'package:wash_it/presentation/address_page/edit_address_page.dart';
import 'package:wash_it/presentation/address_page/widgets/pop_up/more_button_pop_up.dart';

import '../../widgets/common/main_container_widget.dart';
import '../../widgets/common/mainpage_appbar_widget.dart';
import 'controllers/address_page.controller.dart';

class AddressPageScreen extends GetView<AddressPageController> {
  const AddressPageScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainpageAppbarWidget(title: "Alamat"),
      body: RefreshIndicator(
        onRefresh: () async => controller.getAddressUser(),
        child: Obx(
          () {
            if (controller.isLoading.value) {
              return Center(child: CupertinoActivityIndicator());
            }
            if (!controller.addressList.isEmpty) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: controller.isLoading.value
                        ? NeverScrollableScrollPhysics()
                        : AlwaysScrollableScrollPhysics(),
                    itemCount: controller.addressList.length,
                    itemBuilder: (context, index) {
                      var address = controller.addressList[index];
                      return _buildAddressItem(context, controller, address);
                    }),
              );
            }
            return Center(child: Text("Tidak ada alamat"));
          },
        ),
      ),
      floatingActionButton: Obx(() =>
          !controller.isLoading.value ? _buildAddAddressButton() : Container()),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

Widget _buildAddressItem(
    BuildContext context, AddressPageController controller, address) {
  return Padding(
    padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
    child: MainContainerWidget(
      childs: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text("${address['type']}",
                    style: tsBodySmallSemibold(black)),
              ),
              Visibility(
                  visible: address['is_primary'],
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: secondaryColor.withOpacity(0.2)),
                      child: Text("Alamat Utama",
                          style: tsLabelMediumMedium(secondaryColor))))
            ]),
            SizedBox(height: 10),
            Text(
              "${address['street']}, ${address['village']}, ${address['district']}, ${address['city']}, ${address['province']}, ${address['postal_code']}",
              style: tsLabelLargeMedium(black.withOpacity(0.7)),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () => moreButtonPopUp(context, controller, address),
                    child: MainContainerWidget(
                      height: 38,
                      childs: Center(
                        child: Icon(Icons.more_horiz_rounded,
                            color: darkGrey, size: 18),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  flex: 8,
                  child: InkWell(
                    onTap: () {
                      print(address['province']);
                      Get.to(() => EditAddressPage(
                            editType: 'edit',
                            id: address['id'],
                            label: address['type'],
                            province: address['province'],
                            city: address['city'],
                            district: address['district'],
                            village: address['village'],
                            street: address['street'],
                            postal: address['postal_code'],
                            isPrimary: address['is_primary'],
                            // notes: address['notes'],
                          ));
                    },
                    child: MainContainerWidget(
                      height: 38,
                      childs: Center(
                        child: Text("Ubah Alamat",
                            style: tsLabelLargeSemibold(darkGrey)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildAddAddressButton() {
  return Container(
      decoration: BoxDecoration(
          color: primaryColor,
          border: Border(
              top: BorderSide(
            color: lightGrey,
            width: 01,
          ))),
      child: Padding(
          padding: const EdgeInsets.all(defaultMargin),
          child: InkWell(
              onTap: () => Get.to(() => EditAddressPage(
                    isPrimary: false,
                    editType: 'add',
                  )),
              child: Container(
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 50,
                  child: Center(
                    child: Text("Tambah Alamat",
                        style: tsBodySmallSemibold(primaryColor)),
                  )))));
}
