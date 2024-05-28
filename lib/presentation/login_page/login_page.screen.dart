import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wash_it/infrastructure/navigation/routes.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';
import 'package:wash_it/widget/common/auth_text_field.dart';
import 'package:wash_it/widget/common/button_widget.dart';

import 'controllers/login_page.controller.dart';

class LoginPageScreen extends GetView<LoginPageController> {
  const LoginPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    final _emailKey = GlobalKey<FormState>();
    final _passwordKey = GlobalKey<FormState>();
    return Scaffold(
        body: Container(
      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight * 0.1,
            ),
            Text(
              "Login",
              style: tsHeadlineMediumSemibold(black),
            ),
            Text(
              "Masukkan Email Dan Password",
              style: tsBodyMediumRegular(darkGrey),
            ),
            SizedBox(
              height: 35,
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
              formKey: _emailKey,
              validator: (value) {
                final emailRegex = RegExp(
                  r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
                );
                if (value == null || value.isEmpty) {
                  return "Email tidak boleh kosong";
                } else if (!emailRegex.hasMatch(value)) {
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
              "Password",
              style: tsBodyMediumMedium(black),
            ),
            SizedBox(
              height: 12,
            ),
            Obx(() => AuthTextField(
                  hintText: "Masukkan Password",
                  onChanged: (value) {},
                  formKey: _passwordKey,
                  isObsecure: controller.isObsecure.value,
                  suffixIcon: IconButton(
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
                  ),
                )),
            Container(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {},
                child: Text(
                  "Lupa Password?",
                  style: tsLabelLargeRegular(darkBlue),
                ),
              ),
            ),
            SizedBox(
              height: 15,
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
                            "Login",
                            style: tsBodyMediumSemibold(primaryColor),
                          ),
                        ),
                  backgroundColor: secondaryColor,
                  onPressed: () {
                    if (_emailKey.currentState!.validate() &&
                        _passwordKey.currentState!.validate()) {
                      controller.login(); 
                    }
                      
                  },
                )),
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
                        "Login Dengan Google",
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
                  "Belum punya akun?",
                  style: tsBodyMediumMedium(darkGrey),
                ),
                TextButton(
                  onPressed: () {
                    Get.offNamed(Routes.REGISTER_PAGE);
                  },
                  child: Text(
                    "Daftar Sekarang",
                    style: tsBodyMediumBold(darkBlue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
