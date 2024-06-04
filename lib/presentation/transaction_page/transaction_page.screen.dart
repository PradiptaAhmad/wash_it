import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../infrastructure/navigation/routes.dart';
import '../../infrastructure/theme/themes.dart';
import '../../widget/common/button_widget.dart';
import '../history_page/widget/detail_text_widget.dart';
import 'controllers/transaction_page.controller.dart';

class TransactionPageScreen extends GetView<TransactionPageController> {
  const TransactionPageScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Iconsax.arrow_left_2,
          ),
          onPressed: () {
            Get.toNamed(Routes.NAVBAR);
          },
        ),
        backgroundColor: primaryColor,
        title:
            Text("Detail Riwayat Transaksi", style: tsBodyLargeMedium(black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
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
                    SizedBox(height: 5),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("23/03", style: tsBodySmallRegular(black)),
                          Text("Est.", style: tsBodySmallRegular(black)),
                          Text("25/03", style: tsBodySmallRegular(black)),
                        ],
                      ),
                    ),
                  ],
                ),
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
                  Container(
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    height: 35,
                    width: 35,
                    child: Icon(Iconsax.call5, color: primaryColor),
                  ),
                  SizedBox(width: 5),
                  Container(
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    height: 35,
                    width: 35,
                    child: Icon(Iconsax.message5, color: primaryColor),
                  )
                ],
              ),
              DetailDataWidget(
                  leftTitle: "No. Pemesanan", rightTitle: "0441768479184"),
              DetailDataWidget(
                  leftTitle: "Nama Pelanggan", rightTitle: "081245678908"),
              DetailDataWidget(
                  leftTitle: "Nomor Ponsel", rightTitle: "081245678908"),
              DetailDataWidget(
                  leftTitle: "Alamat", rightTitle: "Sanggrahan, Karanganyar"),
              DetailDataWidget(
                  leftTitle: "Tipe Laundry", rightTitle: "Cuci Regular"),
              DetailDataWidget(leftTitle: "Berat (Kg)", rightTitle: "4 Kg"),
              DetailDataWidget(
                  leftTitle: "Tanggal Pemesanan", rightTitle: "23 Maret 2024"),
              SizedBox(height: 20),
              Text(
                "Detail Pembayaran",
                style: tsBodyMediumMedium(black),
              ),
              DetailDataWidget(
                  leftTitle: "Nomor Referensi", rightTitle: "00000876416789"),
              DetailDataWidget(
                  leftTitle: "Status Pembayaran", rightTitle: "Sukses"),
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
                    "Rp. 12.000,00",
                    style: tsBodyMediumMedium(black),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ButtonWidget(
                backgroundColor: secondaryColor,
                child: Text(
                  "Beri Penilaian",
                  style: tsBodySmallSemibold(primaryColor),
                ),
                onPressed: () {
                  Get.toNamed(Routes.REVIEW_PAGE);
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}