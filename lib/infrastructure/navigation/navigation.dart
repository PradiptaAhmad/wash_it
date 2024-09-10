import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:wash_it/infrastructure/navigation/bindings/controllers/order_antarjemput.controller.binding.dart';
import 'package:wash_it/infrastructure/navigation/bindings/controllers/splash.controller.binding.dart';
import 'package:wash_it/infrastructure/navigation/navigation_menu.dart';
import 'package:wash_it/presentation/address_page/edit_address_page.dart';
import 'package:wash_it/presentation/profile_page/profile_page.dart';
import 'package:wash_it/presentation/splash_screen/splash_screen.dart';

import '../../config.dart';
import '../../presentation/order_page/order_page.screen.dart';
import '../../presentation/profile_page/profile_change_page.dart';
import '../../presentation/screens.dart';
import 'bindings/controllers/controllers_bindings.dart';
import 'bindings/controllers/profile_page.binding.dart';
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
      binding: LoginPageControllerBinding(),
    ),
    GetPage(
      name: Routes.REGISTER_PAGE,
      page: () => RegisterPageScreen(),
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
      binding: ProfilePageControllerBinding(),
    ),
    GetPage(
      name: Routes.HISTORY_PAGE,
      page: () => HistoryPageScreen(),
      binding: HistoryPageControllerBinding(),
    ),
    GetPage(
      name: Routes.VERIFICATION_PAGE,
      page: () => VerificationPageScreen(),
      binding: VerificationPageControllerBinding(),
    ),
    GetPage(
      name: Routes.STATUS_PAGE,
      page: () => const StatusPageScreen(),
      binding: StatusPageControllerBinding(),
    ),
    GetPage(
      name: Routes.TRANSACTION_PAGE,
      page: () => TransactionPageScreen(),
      binding: TransactionPageControllerBinding(),
    ),
    GetPage(
      name: Routes.PROFILE_CHANGE_PAGE,
      page: () => ProfileChangePage(),
    ),
    GetPage(
      name: Routes.NOTIFICATION_PAGE,
      page: () => const NotificationPageScreen(),
      binding: NotificationPageControllerBinding(),
    ),
    GetPage(
      name: Routes.REVIEW_PAGE,
      page: () => const ReviewPageScreen(),
      binding: ReviewPageControllerBinding(),
    ),
    GetPage(
      name: Routes.PAYMENT_PAGE,
      page: () => PaymentPageScreen(),
      binding: PaymentPageControllerBinding(),
    ),
    GetPage(
      name: Routes.ADDRESS_PAGE,
      page: () => const AddressPageScreen(),
      binding: AddressPageControllerBinding(),
    ),
    GetPage(
        name: Routes.EDIT_ADDRESS_PAGE,
        page: () => EditAddressPage(
              editType: 'add',
              isPrimary: false,
            ),
        binding: AddressPageControllerBinding()),
    GetPage(
      name: Routes.MAP_GOOGLE,
      page: () => const MapGoogleScreen(),
      binding: MapGoogleControllerBinding(),
    ),
  ];
}
