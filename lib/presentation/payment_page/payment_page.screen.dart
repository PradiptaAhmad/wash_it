import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../infrastructure/theme/themes.dart';
import '../../widget/common/main_container_widget.dart';
import '../../widget/common/mainpage_appbar_widget.dart';
import '../transaction_page/widget/detail_text_widget.dart';
import 'controllers/payment_page.controller.dart';

class PaymentPageScreen extends GetView<PaymentPageController> {
  PaymentPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainpageAppbarWidget(
        icon: Icons.close_rounded,
        iconSize: 25,
        title: '',
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(
                child: CupertinoActivityIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(defaultMargin),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(height: 40),
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            color: controller.paymentList['status'] == "PAID"
                                ? successColor.withOpacity(0.2)
                                : pendingOrange.withOpacity(0.2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                color:
                                    controller.paymentList['status'] == "PAID"
                                        ? successColor
                                        : pendingOrange,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                              ),
                              child: Center(
                                child: Icon(
                                  controller.paymentList['status'] == "PAID"
                                      ? Icons.check_rounded
                                      : Icons.priority_high_rounded,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          controller.paymentList['status'] == "PAID"
                              ? "Pembayaran Selesai"
                              : "Selesaikan Pembayaran",
                          style: tsBodyLargeSemibold(black),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 400,
                          child: Text(
                            controller.paymentList['status'] == "PAID"
                                ? "Pembayaran telah selesai dan pesanan anda sedang diproses"
                                : "Segera selesaikan pembayaran untuk melanjutkan proses pemesanan",
                            textAlign: TextAlign.center,
                            maxLines: 4,
                            style: tsBodySmallMedium(darkGrey),
                          ),
                        ),
                        SizedBox(height: 20),
                        MainContainerWidget(
                          width: double.infinity,
                          childs: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                SizedBox(height: 5),
                                DetailDataWidget(
                                  leftTitle: "Detail Pembayaran",
                                  leftTitleStyle: tsBodySmallSemibold(black),
                                  rightTitle: "",
                                ),
                                SizedBox(height: 10),
                                DetailDataWidget(
                                  leftTitle: "Tanggal pembayaran",
                                  rightTitle:
                                      "${DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(DateTime.parse(controller.paymentList['paid_at'] ?? "2007-07-31 00:00:00"))}",
                                ),
                                SizedBox(height: 5),
                                DetailDataWidget(
                                  leftTitle: "Tipe pembayaran",
                                  rightTitle:
                                      controller.paymentList['payment_type'] ==
                                              "non_tunai"
                                          ? "Non Tunai"
                                          : "Tunai",
                                ),
                                SizedBox(height: 5),
                                DetailDataWidget(
                                  leftTitle: "Metode pembayaran",
                                  rightTitle:
                                      "${controller.paymentList['payment_method']}",
                                ),
                                SizedBox(height: 5),
                                DetailDataWidget(
                                  leftTitle: "Kanal pembayaran",
                                  rightTitle:
                                      "${controller.paymentList['payment_channel']}",
                                ),
                                SizedBox(height: 5),
                                DetailDataWidget(
                                  leftTitle: "Total",
                                  rightTitle: controller
                                              .paymentList['amount'] ==
                                          null
                                      ? "${NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0).format(controller.argument[1])}"
                                      : "Rp ${NumberFormat("#,##0", "id_ID").format(int.parse(controller.paymentList['amount']))}",
                                ),
                                SizedBox(height: 5),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
      floatingActionButton: Obx(
        () => controller.isLoading.value ||
                controller.paymentList['status'] == "PAID"
            ? Container()
            : Padding(
                padding: const EdgeInsets.all(defaultMargin),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () => controller.fetchPaymentDetail(),
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        decoration: BoxDecoration(
                          color: secondaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        height: 50,
                        child: Center(
                          child: Text("Cek status pembayaran",
                              style: tsBodySmallSemibold(secondaryColor)),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () => controller.createPayment(),
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        height: 50,
                        child: Center(
                          child: Text("Bayar",
                              style: tsBodySmallSemibold(primaryColor)),
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
