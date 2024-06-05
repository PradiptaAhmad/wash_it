import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';
import 'package:wash_it/presentation/verification_page/controllers/verification_page.controller.dart';

class OtpFormWidget extends GetView<VerificationPageController> {
  const OtpFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SingleFormWidget(context),
        SingleFormWidget(context),
        SingleFormWidget(context),
        SingleFormWidget(context),
        SingleFormWidget(context),
        SingleFormWidget(context),
      ],
    ));
  }
}

Widget SingleFormWidget(BuildContext context) {
  final controller = Get.find<VerificationPageController>();
  return SizedBox(
    height: 68,
    width: 60,
    child: TextField(
      onChanged: (value) {
        if (value.length == 1) {
          controller.otp.value += value;
          FocusScope.of(context).nextFocus();
        } else if (value.isEmpty) {
          controller.otp.value = controller.otp.value
              .substring(0, controller.otp.value.length - 1);
          FocusScope.of(context).previousFocus();
        }
      },
      style: Theme.of(context).textTheme.headlineSmall,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: darkBlue,
            )),
        focusColor: darkBlue,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 2,
              color: secondaryColor,
            )),
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(1),
        FilteringTextInputFormatter.digitsOnly
      ],
    ),
  );
}
