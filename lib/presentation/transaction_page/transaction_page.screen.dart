import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wash_it/infrastructure/navigation/routes.dart';
import 'package:wash_it/presentation/transaction_page/widget/detail_text_widget.dart';
import 'package:wash_it/presentation/transaction_page/widget/more_options_bottomsheets_widget.dart';
import 'package:wash_it/presentation/transaction_page/widget/review_pop_up_widget.dart';
import 'package:wash_it/presentation/transaction_page/widget/transaction_status_progress_widget.dart';

import '../../infrastructure/theme/themes.dart';
import '../../widgets/common/main_container_widget.dart';
import '../../widgets/common/mainpage_appbar_widget.dart';
import '../../widgets/popup/custom_snackbar.dart';
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
        () {
          if (controller.isLoading.value) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
          return RefreshIndicator(
            onRefresh: () async => controller.onRefresh(),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(defaultMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                      visible: true,
                      child: MainContainerWidget(
                          width: double.infinity,
                          childs: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(children: [
                                SizedBox(height: 5),
                                TransactionStatusProgressWidget()
                              ])))),
                  SizedBox(height: 10),
                  MainContainerWidget(
                      width: double.infinity,
                      childs: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: [
                            SizedBox(height: 5),
                            DetailDataWidget(
                                leftTitle: "STATUS PEMESANAN",
                                leftTitleStyle: tsBodySmallSemibold(grey),
                                rightTitle: ""),
                            SizedBox(height: 10),
                            DetailDataWidget(
                                leftTitle: "Tanggal pemesanan",
                                rightTitle:
                                    "${DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(DateTime.parse(controller.ordersList['tanggal_pemesanan'] ?? "1443-07-31 00:00:00"))}"),
                            SizedBox(height: 5),
                            DetailDataWidget(
                                leftTitle: "Tanggal estimasi",
                                rightTitle:
                                    "${DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(DateTime.parse(controller.ordersList['tanggal_pengambilan'] ?? "2007-07-31 00:00:00"))}"),
                            SizedBox(height: 5),
                          ]))),
                  SizedBox(height: 10),
                  MainContainerWidget(
                      width: double.infinity,
                      childs: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(children: [
                            SizedBox(height: 5),
                            DetailDataWidget(
                              leftTitle: "DETAIL PEMESANAN",
                              leftTitleStyle: tsBodySmallSemibold(grey),
                            ),
                            SizedBox(height: 10),
                            DetailDataWidget(
                                leftTitle: "Nama",
                                rightTitle:
                                    "${controller.ordersList['nama_pemesan']}",
                                textTitleOverflow: TextOverflow.visible),
                            SizedBox(height: 5),
                            DetailDataWidget(
                                leftTitle: "No. Pemesanan",
                                rightTitle:
                                    "${controller.ordersList['no_pemesanan']}"),
                            SizedBox(height: 5),
                            DetailDataWidget(
                                leftTitle: "Jenis pemesanan",
                                rightTitle:
                                    controller.ordersList['jenis_pemesanan'] ==
                                            'antar_mandiri'
                                        ? "Antar mandiri"
                                        : "Antar Jemput"),
                            SizedBox(height: 5),
                            DetailDataWidget(
                                leftTitle: "Tipe laundry",
                                rightTitle:
                                    "${controller.ordersList['laundry_service']}"),
                            SizedBox(height: 5),
                            DetailDataWidget(
                                leftTitle: "Berat laundry",
                                rightTitle: controller
                                            .ordersList['berat_laundry'] ==
                                        null
                                    ? "Berat belum tercatat"
                                    : "${controller.ordersList['berat_laundry'].toString()} Kg"),
                            SizedBox(height: 5),
                            DetailDataWidget(
                                leftTitle: "Catatan",
                                rightTitle: controller.ordersList['catatan'] ==
                                        null
                                    ? "Tidak ada catatan"
                                    : "${controller.ordersList['catatan']}"),
                            SizedBox(height: 5)
                          ]))),
                  Visibility(
                      visible: controller.ordersList['jenis_pemesanan'] ==
                              'antar_mandiri'
                          ? false
                          : true,
                      child: Column(children: [
                        SizedBox(height: 10),
                        MainContainerWidget(
                            width: double.infinity,
                            childs: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(children: [
                                  SizedBox(height: 5),
                                  DetailDataWidget(
                                      leftTitle: "DETAIL PENGIRIMAN",
                                      leftTitleStyle: tsBodySmallSemibold(grey),
                                      rightTitle: ""),
                                  SizedBox(height: 10),
                                  DetailDataWidget(
                                      leftTitle: "Nomor ponsel",
                                      rightTitle:
                                          "${controller.ordersList['nomor_telepon']}",
                                      textTitleOverflow: TextOverflow.visible),
                                  SizedBox(height: 5),
                                  DetailDataWidget(
                                      leftTitle: "Alamat",
                                      rightTitle:
                                          "${controller.ordersList['alamat']}",
                                      textTitleOverflow: TextOverflow.ellipsis),
                                  SizedBox(height: 5),
                                ])))
                      ])),
                  SizedBox(height: 10),
                  Visibility(
                    child: MainContainerWidget(
                        width: double.infinity,
                        childs: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(children: [
                              SizedBox(height: 10),
                              DetailDataWidget(
                                  leftTitle: "Metode pembayaran",
                                  rightTitle: controller.ordersList[
                                              'metode_pembayaran'] ==
                                          "tunai"
                                      ? "Tunai"
                                      : "Non Tunai"),
                              SizedBox(height: 5),
                              DetailDataWidget(
                                  leftTitle: "Harga laundry",
                                  rightTitle: "Rp 6.000 x " +
                                      "${controller.ordersList['berat_laundry'] == null ? "0" : controller.ordersList['berat_laundry']} Kg"),
                              SizedBox(height: 5),
                              Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Divider(
                                      color: lightGrey, thickness: 0.5)),
                              DetailDataWidget(
                                  leftTitle: "Total harga",
                                  rightTitle: controller
                                              .ordersList['total_harga'] ==
                                          null
                                      ? "Harga belum tercatat"
                                      : "${NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0).format(controller.ordersList['total_harga'])}"),
                              SizedBox(height: 5),
                            ]))),
                  ),
                  SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: Obx(() => !controller.isLoading.value
          ? _buildFloatingActionButton(context, controller)
          : Container()),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

Widget _buildFloatingActionButton(
    BuildContext context, TransactionPageController controller) {
  return Container(
    decoration: BoxDecoration(
        color: primaryColor,
        border: Border(top: BorderSide(color: lightGrey, width: 01))),
    child: Padding(
      padding: const EdgeInsets.all(defaultMargin),
      child: Row(
        children: [
          Visibility(
            visible: controller.argument[1] == 'order' &&
                controller.statusList['status_code'] == 1 &&
                controller.ordersList['metode_pembayaran'] == 'non_tunai',
            child: Expanded(
              flex: 1,
              child: InkWell(
                onTap: () => moreOptionsBottomsheetsWidget(context, controller),
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
          ),
          SizedBox(width: 5),
          Expanded(
            flex: 6,
            child: InkWell(
              onTap: () {
                if (controller.displayText.value == "Batalkan Pesanan") {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Konfirmasi'),
                        content: const Text(
                            'Apakah Anda yakin ingin membatalkan pesanan ini?'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Batal'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('Ya'),
                            onPressed: () {
                              controller.putOrderCancel();
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else if (controller.statusList['status_code'] == 5) {
                  controller.putCompleteOrder();
                } else if (controller.argument[1] == 'order') {
                  controller.ordersList['total_harga'] == null
                      ? customSnackBar('Gagal', 'Total harga belum terhitung',
                          warningColor, primaryColor)
                      : Get.toNamed(Routes.PAYMENT_PAGE, arguments: [
                          controller.ordersList['id'],
                          controller.ordersList['total_harga'],
                          controller.ordersList['metode_pembayaran'],
                        ]);
                  ;
                } else {
                  reviewPopUpWidget(context, controller);
                }
              },
              borderRadius: BorderRadius.circular(15),
              child: Container(
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 50,
                child: Center(
                  child: Text("${controller.displayText.value}",
                      style: tsBodySmallSemibold(primaryColor)),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
