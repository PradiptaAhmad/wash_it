import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';
import 'package:wash_it/presentation/splash_screen/controllers/splash_screen.controller.dart';

class SplashScreen extends GetView<SplashPageController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(controller.text.value);
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Image.asset(
          'assets/icons/logo.png',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
