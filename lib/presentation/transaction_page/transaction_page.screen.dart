import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wash_it/presentation/transaction_page/widget/detail_text_widget.dart';
import 'package:wash_it/widget/common/mainpage_appbar_widget.dart';

import '../../infrastructure/navigation/routes.dart';
import '../../infrastructure/theme/themes.dart';
import '../../widget/common/button_widget.dart';
import 'controllers/transaction_page.controller.dart';

class TransactionPageScreen extends GetView<TransactionPageController> {
  TransactionPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainpageAppbarWidget(
          title: 'Detail Transaksi',
        ),
        body: Obx(
          () => controller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.all(defaultMargin),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Iconsax.receipt,
                                  size: 30,
                                  color: successColor,
                                ),
                                DottedLine(
                                  direction: Axis.horizontal,
                                  lineLength: 40,
                                  lineThickness: 2,
                                  dashLength: 5,
                                  dashColor: successColor,
                                ),
                                Icon(
                                  Iconsax.wallet_1,
                                  size: 30,
                                  color: successColor,
                                ),
                                DottedLine(
                                  direction: Axis.horizontal,
                                  lineLength: 40,
                                  lineThickness: 2,
                                  dashLength: 5,
                                  dashColor: successColor,
                                ),
                                Icon(
                                  Iconsax.bubble,
                                  size: 30,
                                  color: successColor,
                                ),
                                DottedLine(
                                  direction: Axis.horizontal,
                                  lineLength: 40,
                                  lineThickness: 2,
                                  dashLength: 5,
                                  dashColor: successColor,
                                ),
                                Icon(
                                  Iconsax.location,
                                  size: 30,
                                  color: successColor,
                                ),
                                DottedLine(
                                  direction: Axis.horizontal,
                                  lineLength: 40,
                                  lineThickness: 2,
                                  dashLength: 5,
                                  dashColor: successColor,
                                ),
                                Icon(
                                  Iconsax.verify,
                                  size: 30,
                                  color: successColor,
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "${controller.ordersList['tanggal_pemesanan_only_date']}",
                                      style: tsBodySmallRegular(black)),
                                  Text("Estimasi",
                                      style: tsBodySmallRegular(black)),
                                  Text(
                                      "${controller.ordersList['tanggal_pengambilan']}",
                                      style: tsBodySmallRegular(black)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Center(
                            child: Text("Pesanan Telah Selesai",
                                style: tsBodySmallMedium(black))),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "History Detail Page",
                                style: tsBodyMediumMedium(black),
                              ),
                            ),
                            InkWell(
                              onTap: () => Get.toNamed(Routes.CHAT_PAGE),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: secondaryColor,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                height: 35,
                                width: 35,
                                child: Icon(
                                  Icons.message_rounded,
                                  color: primaryColor,
                                  size: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                        DetailDataWidget(
                            leftTitle: "No. Pemesanan",
                            rightTitle:
                                "${controller.ordersList['no_pemesanan']}"),
                        DetailDataWidget(
                            leftTitle: "Nama Pelanggan",
                            rightTitle:
                                "${controller.ordersList['nama_pemesan']}"),
                        DetailDataWidget(
                            leftTitle: "Nomor Ponsel",
                            rightTitle:
                                "${controller.ordersList['nomor_telepon']}"),
                        DetailDataWidget(
                            leftTitle: "Alamat",
                            rightTitle: "${controller.ordersList['alamat']}"),
                        DetailDataWidget(
                            leftTitle: "Tipe Laundry",
                            rightTitle:
                                "${controller.ordersList['laundry_service']['nama_laundry']}"),
                        DetailDataWidget(
                            leftTitle: "Berat (Kg)",
                            rightTitle: controller
                                        .ordersList['berat_laundry'] ==
                                    null
                                ? "Berat Belum Dihitung"
                                : "${controller.ordersList['berat_laundry'].toString()} Kg"),
                        DetailDataWidget(
                          leftTitle: "Tanggal Pemesanan",
                          rightTitle:
                              "${controller.ordersList['tanggal_pemesanan']}",
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Detail Pembayaran",
                          style: tsBodyMediumMedium(black),
                        ),
                        DetailDataWidget(
                          leftTitle: "Nomor Referensi",
                          rightTitle: "00000876416789",
                        ),
                        DetailDataWidget(
                          leftTitle: "Status Pembayaran",
                          rightTitle: "Sukses",
                        ),
                        DetailDataWidget(
                            leftTitle: "Waktu Pembayaran",
                            rightTitle: "25-03-2024,  12:22:12"),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Total Harga",
                                style: tsBodyMediumMedium(black),
                              ),
                            ),
                            Text(
                              "Rp. 25.000,00",
                              style: tsBodyMediumMedium(black),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Divider(color: lightGrey, thickness: 1),
                        ),
                        ButtonWidget(
                          backgroundColor: secondaryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(defaultMargin),
                            child: Text("Bayar Sekarang",
                                style: tsBodySmallSemibold(primaryColor)),
                          ),
                          onPressed: () {
                            Get.toNamed(Routes.PAYMENT_PAGE);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
        ));
  }
}
