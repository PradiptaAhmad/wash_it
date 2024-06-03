import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';

import 'controllers/verification_page.controller.dart';
import 'otp_form_widget.dart';

class VerificationPageScreen extends GetView<VerificationPageController> {
  const VerificationPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 1),
              Text(
                "Kode Verifikasi",
                style: tsTitleSmallMedium(black),
              ),
              SizedBox(height: 10),
              Text("Kode Verifikasi Telah Terkirim Kepada Nomor Tertera",
                  style: tsLabelLargeRegular(black)),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(controller.formatPhoneNumber(),
                      style: tsBodySmallMedium(black)),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Ganti Nomor?",
                      style: tsLabelLargeSemibold(secondaryColor))
                ],
              ),
              SizedBox(height: 10),
              OtpFormWidget(),
              SizedBox(height: 5),
              Row(
                children: [
                  Obx(
                    () => controller.timeleft.value == 0
                        ? InkWell(
                            borderRadius: BorderRadius.circular(4),
                            onTap: () {},
                            child: Text(
                              "Kirim Ulang?",
                              style: tsLabelLargeSemibold(secondaryColor),
                            ),
                          )
                        : Text(
                            "Kirim Ulang?",
                            style: tsLabelLargeSemibold(darkGrey),
                          ),
                  ),
                  Obx(() => controller.timeleft.value > 0
                      ? Text(
                          "Kirim Ulang Dalam ${controller.timeleft.value} detik",
                          style: tsLabelLargeRegular(black),
                        )
                      : Text("")),
                ],

              )
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Row(
          children: [
            Expanded(
              child: FloatingActionButton(
                onPressed: () {},
                elevation: 3,
                backgroundColor: secondaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  "Konfirmasi",
                  style: tsBodySmallSemibold(primaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
