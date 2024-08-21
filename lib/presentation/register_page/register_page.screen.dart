import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:wash_it/infrastructure/navigation/routes.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';
import 'package:wash_it/widgets/common/auth/auth_text_field.dart';
import 'package:wash_it/widgets/common/auth/divider_widget.dart';
import 'package:wash_it/widgets/common/auth/input_form_widget.dart';
import 'package:wash_it/widgets/common/button_widget.dart';
import 'controllers/register_page.controller.dart';

class RegisterPageScreen extends GetView<RegisterPageController> {
  final _usernameKey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormState>();
  final _phoneKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormState>();

  RegisterPageScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
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
                InputFormWidget(
                  title: "Username",
                  hintText: "Masukkan Username",
                  formKey: _usernameKey,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Username tidak boleh kosong";
                    } else {
                      controller.username.value = value;
                      return null;
                    }
                  },
                ),
                InputFormWidget(
                  title: "Email",
                  hintText: "Masukkan Email",
                  textField: AuthTextField(
                    formKey: _emailKey,
                    hintText: "Masukkan Email",
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email tidak boleh kosong";
                      } else if (!GetUtils.isEmail(value)) {
                        return "Email tidak valid";
                      } else {
                        controller.email.value = value;
                        return null;
                      }
                    },
                  ),
                ),
                InputFormWidget(
                  title: "Nomor Telepon",
                  hintText: "Masukkan Nomor Telepon",
                  textField: AuthTextField(
                    formKey: _phoneKey,
                    hintText: "Masukkan Nomor Telepon",
                    keyboardType: TextInputType.phone,
                    formatter: [
                      LengthLimitingTextInputFormatter(14),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Nomor telepon tidak boleh kosong";
                      } else {
                        controller.phone.value = value;
                        return null;
                      }
                    },
                  ),
                ),
                InputFormWidget(
                  title: "Password",
                  hintText: "Masukkan Password",
                  textField: Obx(() => AuthTextField(
                        formKey: _passwordKey,
                        hintText: "Masukkan Password",
                        isObsecure: controller.isObsecure.value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password tidak boleh kosong";
                          } else {
                            controller.password.value = value;
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
                ),
                SizedBox(
                  height: 20,
                ),
                Obx(() => ButtonWidget(
                      child: controller.isLoading.value
                          ? Container(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Transform.scale(
                                scale: 0.4,
                                child: CircularProgressIndicator(
                                  color: primaryColor,
                                  strokeWidth: 5,
                                ),
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Text(
                                "Daftar",
                                style: tsBodySmallSemibold(primaryColor),
                              ),
                            ),
                      backgroundColor: secondaryColor,
                      onPressed: () {
                        if (_usernameKey.currentState!.validate() &&
                            _emailKey.currentState!.validate() &&
                            _phoneKey.currentState!.validate() &&
                            _passwordKey.currentState!.validate()) {
                          controller.register();
                        }
                        // if (controller.email.value.isNotEmpty &&
                        //     controller.phone.value.isNotEmpty &&
                        //     controller.password.value.isNotEmpty &&
                        //     controller.username.value.isNotEmpty) {

                        //   controller.register();
                        else {
                          print(controller.email.value.isNotEmpty);
                          Get.snackbar("Gagal", "Data tidak boleh kosong",
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: warningColor,
                              colorText: primaryColor);
                        }
                      },
                    )),
                DividerWidget(screenWidth: screenWidth),
                ButtonWidget(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: lightGrey, width: 2),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(defaultMargin),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/icGoogle.svg",
                          width: 20,
                        ),
                        Spacer(),
                        Text(
                          "Login Dengan Google",
                          style: tsBodySmallSemibold(darkBlue),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sudah punya akun?",
                        style: tsBodySmallMedium(darkGrey),
                      ),
                      SizedBox(width: 5),
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.LOGIN_PAGE);
                        },
                        borderRadius: BorderRadius.circular(5),
                        child: Text(
                          "Masuk Sekarang",
                          style: tsBodySmallBold(darkBlue),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
