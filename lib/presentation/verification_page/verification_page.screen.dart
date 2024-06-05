import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';

import 'controllers/verification_page.controller.dart';
import 'otp_form_widget.dart';

class VerificationPageScreen extends GetView<VerificationPageController> {
  const VerificationPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _pinController1 = TextEditingController();
    final TextEditingController _pinController2 = TextEditingController();
    final TextEditingController _pinController3 = TextEditingController();
    final TextEditingController _pinController4 = TextEditingController();
    final TextEditingController _pinController5 = TextEditingController();
    final TextEditingController _pinController6 = TextEditingController();

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
              // OtpFormWidget(),
              Form(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PinFormInput(controller: _pinController1),
                    PinFormInput(controller: _pinController2),
                    PinFormInput(controller: _pinController3),
                    PinFormInput(controller: _pinController4),
                    PinFormInput(controller: _pinController5),
                    PinFormInput(controller: _pinController6),
                  ],
                ),
              ),
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
                onPressed: () {
                  String pinCode = _pinController1.text +
                      _pinController2.text +
                      _pinController3.text +
                      _pinController4.text +
                      _pinController5.text +
                      _pinController6.text;

                  print('Extracted PIN: $pinCode');
                  controller.verifyOtp(pinCode);
                },
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
