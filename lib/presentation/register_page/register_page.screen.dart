import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';
import 'package:wash_it/widget/common/auth_text_field.dart';
import 'package:wash_it/widget/common/button_widget.dart';

import 'controllers/register_page.controller.dart';

class RegisterPageScreen extends GetView<RegisterPageController> {
  const RegisterPageScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * 0.1,
              ),
              Text(
                "Daftar",
                style: tsHeadlineMediumSemibold(black),
              ),
              Text(
                "Masukkan Data Diri Kamu Dibawah Ini",
                style: tsBodyMediumRegular(darkGrey),
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                "Username",
                style: tsBodyMediumMedium(black),
              ),
              SizedBox(
                height: 12,
              ),
              AuthTextField(
                hintText: "Masukkan Username",
                // onChanged: controller.username,

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Username tidak boleh kosong";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Email",
                style: tsBodyMediumMedium(black),
              ),
              SizedBox(
                height: 12,
              ),
              AuthTextField(
                hintText: "Masukkan Email",
                formatter: [
                  LengthLimitingTextInputFormatter(14),
                  FilteringTextInputFormatter.digitsOnly
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email tidak boleh kosong";
                  } else if (!GetUtils.isEmail(value)) {
                    return "Email tidak valid";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Nomor Telepon",
                style: tsBodyMediumMedium(black),
              ),
              SizedBox(
                height: 12,
              ),
              AuthTextField(
                hintText: "Masukkan Nomor Telepon",
                formatter: [
                  LengthLimitingTextInputFormatter(14),
                  FilteringTextInputFormatter.digitsOnly
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Username tidak boleh kosong";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Password",
                style: tsBodyMediumMedium(black),
              ),
              SizedBox(
                height: 12,
              ),
              Obx(() => AuthTextField(
                    hintText: "Masukkan Password",
                    isObsecure: controller.isObsecure.value,
                    formatter: [
                      LengthLimitingTextInputFormatter(14),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Username tidak boleh kosong";
                      } else {
                        return null;
                      }
                    },
                    suffixIcon: Obx(() => IconButton(
                          onPressed: () {
                            controller.isObsecure.value =
                                !controller.isObsecure.value;
                          },
                          icon: Icon(
                            controller.isObsecure.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 22,
                          ),
                        )),
                  )),
              SizedBox(
                height: 20,
              ),
              ButtonWidget(
                text: "Daftar",
                backgroundColor: secondaryColor,
                onPressed: () {},
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    color: lightGrey,
                    width: screenWidth * 0.39,
                    height: 2,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Atau",
                    style: tsBodySmallMedium(darkGrey),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    color: lightGrey,
                    width: screenWidth * 0.39,
                    height: 2,
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: lightGrey, width: 2),
                    ),
                  ),
                  child: Container(
                    height: 25,
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/icGoogle.svg",
                          width: 25,
                        ),
                        Spacer(),
                        Text(
                          "Daftar Dengan Google",
                          style: tsBodyMediumSemibold(darkBlue),
                        ),
                        Spacer(),
                      ],
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sudah punya akun?",
                    style: tsBodyMediumMedium(darkGrey),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      "Masuk Sekarang",
                      style: tsBodyMediumBold(darkBlue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
