import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:wash_it/presentation/transaction_page/widget/detail_text_widget.dart';
import 'package:wash_it/widget/common/main_container_widget.dart';
import 'package:wash_it/widget/common/mainpage_appbar_widget.dart';

import '../../infrastructure/theme/themes.dart';
import 'controllers/transaction_page.controller.dart';

class TransactionPageScreen extends GetView<TransactionPageController> {
  TransactionPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainpageAppbarWidget(
        title: 'Detail transaksi',
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              controller.fetchDetailOrder();
              controller.fetchStatusData();
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(defaultMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MainContainerWidget(
                    width: double.infinity,
                    childs: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(height: 5),
                          OrderStatusIcons(controller: controller),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  MainContainerWidget(
                    width: double.infinity,
                    childs: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(height: 5),
                          DetailDataWidget(
                            leftTitle: "Status Pemesanan",
                            leftTitleStyle: tsBodySmallSemibold(black),
                            rightTitle: "",
                          ),
                          SizedBox(height: 10),
                          DetailDataWidget(
                            leftTitle: "Tanggal pemesanan",
                            rightTitle:
                                "${DateFormat('d MMMM yyyy').format(DateTime.parse(controller.ordersList['tanggal_pemesanan'] ?? "1443-07-31 00:00:00"))}",
                          ),
                          SizedBox(height: 5),
                          DetailDataWidget(
                            leftTitle: "Tanggal estimasi",
                            rightTitle:
                                "${DateFormat('d MMMM yyyy').format(DateTime.parse(controller.ordersList['tanggal_pengambilan'] ?? "2007-07-31 00:00:00"))}",
                          ),
                          SizedBox(height: 5),
                          DetailDataWidget(
                            leftTitle: "Tanggal pembayaran",
                            rightTitle: "27-03-2024 12:22:12",
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  MainContainerWidget(
                    width: double.infinity,
                    childs: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          SizedBox(height: 5),
                          DetailDataWidget(
                            leftTitle: "Info Pemesanan",
                            leftTitleStyle: tsBodySmallSemibold(black),
                            rightTitle: "",
                          ),
                          SizedBox(height: 10),
                          DetailDataWidget(
                            leftTitle: "Nama",
                            rightTitle:
                                "${controller.ordersList['nama_pemesan']}",
                            textTitleOverflow: TextOverflow.visible,
                          ),
                          SizedBox(height: 5),
                          DetailDataWidget(
                            leftTitle: "No. Pemesanan",
                            rightTitle:
                                "${controller.ordersList['no_pemesanan']}",
                          ),
                          SizedBox(height: 5),
                          DetailDataWidget(
                            leftTitle: "Tipe laundry",
                            rightTitle:
                                "${controller.ordersList['laundry_service']['nama_laundry']}",
                          ),
                          SizedBox(height: 5),
                          DetailDataWidget(
                            leftTitle: "Berat laundry",
                            rightTitle: controller
                                        .ordersList['berat_laundry'] ==
                                    null
                                ? "Berat belum tercatat"
                                : "${controller.ordersList['berat_laundry'].toString()} Kg",
                          ),
                          SizedBox(height: 5),
                          DetailDataWidget(
                            leftTitle: "Catatan",
                            rightTitle: "Tidak ditulis",
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  MainContainerWidget(
                    width: double.infinity,
                    childs: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          SizedBox(height: 5),
                          DetailDataWidget(
                            leftTitle: "Info Pengiriman",
                            leftTitleStyle: tsBodySmallSemibold(black),
                            rightTitle: "",
                          ),
                          SizedBox(height: 10),
                          DetailDataWidget(
                            leftTitle: "Nomor ponsel",
                            rightTitle:
                                "${controller.ordersList['nomor_telepon']}",
                            textTitleOverflow: TextOverflow.visible,
                          ),
                          SizedBox(height: 5),
                          DetailDataWidget(
                            leftTitle: "Alamat",
                            rightTitle: "${controller.ordersList['alamat']}",
                            textTitleOverflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  MainContainerWidget(
                    width: double.infinity,
                    childs: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          DetailDataWidget(
                            leftTitle: "Metode pembayaran",
                            rightTitle:
                                controller.ordersList['metode_pembayaran'] ==
                                        "tunai"
                                    ? "Tunai"
                                    : "Cashless",
                          ),
                          SizedBox(height: 5),
                          DetailDataWidget(
                            leftTitle: "Harga laundry",
                            rightTitle: "Rp 6.000 X 7 Kg",
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Divider(color: lightGrey, thickness: 0.5),
                          ),
                          DetailDataWidget(
                            leftTitle: "Total harga",
                            rightTitle: controller.ordersList['total_harga'] ==
                                    null
                                ? "Harga belum tercatat"
                                : "Rp ${controller.ordersList['total_harga']}",
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: Obx(
        () => controller.isLoading.value
            ? Container()
            : Padding(
                padding: const EdgeInsets.all(defaultMargin),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          height: 50,
                          child: Center(
                            child: Icon(
                              Icons.menu_rounded,
                              color: primaryColor,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      flex: 6,
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          height: 50,
                          child: Center(
                            child: Text("Ulas Sekarang",
                                style: tsBodySmallSemibold(primaryColor)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class OrderStatusIcons extends StatelessWidget {
  const OrderStatusIcons({
    super.key,
    required this.controller,
  });

  final TransactionPageController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Iconsax.receipt,
              size: 30,
              color: controller.statusList['status_code'] >= 0
                  ? successColor
                  : lightGrey,
            ),
            DottedLine(
              direction: Axis.horizontal,
              lineLength: 40,
              lineThickness: 2,
              dashLength: 5,
              dashColor: controller.statusList['status_code'] >= 1
                  ? successColor
                  : lightGrey,
            ),
            Icon(
              Iconsax.wallet_1,
              size: 30,
              color: controller.statusList['status_code'] >= 1
                  ? successColor
                  : lightGrey,
            ),
            DottedLine(
              direction: Axis.horizontal,
              lineLength: 40,
              lineThickness: 2,
              dashLength: 5,
              dashColor: controller.statusList['status_code'] >= 2
                  ? successColor
                  : lightGrey,
            ),
            Icon(
              Iconsax.bubble,
              size: 30,
              color: controller.statusList['status_code'] >= 2
                  ? successColor
                  : lightGrey,
            ),
            DottedLine(
              direction: Axis.horizontal,
              lineLength: 40,
              lineThickness: 2,
              dashLength: 5,
              dashColor: controller.statusList['status_code'] >= 3
                  ? successColor
                  : lightGrey,
            ),
            Icon(
              Iconsax.location,
              size: 30,
              color: controller.statusList['status_code'] >= 3
                  ? successColor
                  : lightGrey,
            ),
            DottedLine(
              direction: Axis.horizontal,
              lineLength: 40,
              lineThickness: 2,
              dashLength: 5,
              dashColor: controller.statusList['status_code'] >= 4
                  ? successColor
                  : lightGrey,
            ),
            Icon(
              Iconsax.verify,
              size: 30,
              color: controller.statusList['status_code'] >= 4
                  ? successColor
                  : lightGrey,
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          "${controller.statusList['status_description']}",
          style: tsBodySmallMedium(black),
        ),
      ],
    );
  }
}
