import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wash_it/infrastructure/navigation/bindings/controllers/order_antarjemput.controller.binding.dart';
import 'package:wash_it/infrastructure/navigation/bindings/controllers/splash.controller.binding.dart';
import 'package:wash_it/presentation/onboarding_page/boarding_screen.dart';
import 'package:wash_it/presentation/order_antarjemput/order_view.dart';
import 'package:wash_it/presentation/profile_page/profile_controller.dart';
import 'package:wash_it/presentation/profile_page/profile_page.dart';
import 'package:wash_it/presentation/splash_screen/controllers/splash_screen.controller.dart';
import 'package:wash_it/infrastructure/navigation/navigation_menu.dart';
import 'package:wash_it/presentation/splash_screen/splash_screen.dart';

import '../../config.dart';
import '../../presentation/screens.dart';
import 'bindings/controllers/controllers_bindings.dart';
import 'routes.dart';

class EnvironmentsBadge extends StatelessWidget {
  final Widget child;

  EnvironmentsBadge({required this.child});

  @override
  Widget build(BuildContext context) {
    var env = ConfigEnvironments.getEnvironments()['env'];
    return env != Environments.PRODUCTION
        ? Banner(
            location: BannerLocation.topStart,
            message: env!,
            color: env == Environments.QAS ? Colors.blue : Colors.purple,
            child: child,
          )
        : SizedBox(child: child);
  }
}

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.NAVBAR,
      page: () => NavigationMenu(),
    ),
    GetPage(
      name: Routes.ONBOARDING_PAGE,
      page: () => BoardingScreen(),
    ),
    GetPage(
      name: Routes.SPLASH_SCREEN,
      page: () => SplashScreen(),
      binding: SplashControllerBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeScreen(),
      binding: HomeControllerBinding(),
    ),
    GetPage(
      name: Routes.LOGIN_PAGE,
      page: () => const LoginPageScreen(),
      binding:  LoginPageControllerBinding(),
    ),
    GetPage(
      name: Routes.REGISTER_PAGE,
      page: () => const RegisterPageScreen(),
      binding: RegisterPageControllerBinding(),
    ),
    GetPage(
      name: Routes.ORDERANTARJEMPUT_PAGE,
      page: () => OrderView(),
      binding: OrderAntarJemputPageControllerBinding(),
    ),
    GetPage(
      name: Routes.PROFILE_PAGE,
      page: () => ProfilePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ProfileController>(() => ProfileController());
      }),
    ),
  ];
}
