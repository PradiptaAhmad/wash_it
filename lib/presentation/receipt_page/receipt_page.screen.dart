import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../infrastructure/navigation/routes.dart';
import '../../infrastructure/theme/themes.dart';
import '../../widget/common/button_widget.dart';
import '../transaction_page/widget/detail_text_widget.dart';
import 'controllers/receipt_page.controller.dart';

class ReceiptPageScreen extends GetView<ReceiptPageController> {
  const ReceiptPageScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Iconsax.arrow_left_2,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: primaryColor,
        title: Text("Receipt Pembayaran", style: tsBodyLargeMedium(black)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Center(
                  child: Column(
                    children: [
                      MiddleMainLogo(),
                      SizedBox(height: 10),
                      Text(
                        "Pembayaran Berhasil",
                        style: tsBodyLargeMedium(darkBlue),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Rp. 25.000",
                        style: tsTitleMediumSemibold(darkBlue),
                      )
                    ],
                  ),
                ),
              ),
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
              SizedBox(
                height: 20,
              ),
              DottedLine(
                direction: Axis.horizontal,
                lineLength: double.infinity,
                lineThickness: 2,
                dashLength: 3,
                dashColor: lightGrey,
              ),
              SizedBox(
                height: 10,
              ),
              DetailDataWidget(
                  leftTitle: "Total Pembayaran", rightTitle: "IDR 25,000"),
              SizedBox(height: 20),
              ButtonWidget(
                backgroundColor: secondaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(defaultMargin),
                  child:
                      Text("Selesai", style: tsBodySmallSemibold(primaryColor)),
                ),
                onPressed: () {
                  Get.offNamed(Routes.NAVBAR);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MiddleMainLogo extends StatelessWidget {
  const MiddleMainLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        color: successColor.withOpacity(0.2),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: successColor,
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          child: Center(
            child: Icon(
              Icons.check_rounded,
              color: Colors.white, // Change the color as needed
              size: 30,
              // Adjust the size as needed
            ),
          ),
        ),
      ),
    );
  }
}
