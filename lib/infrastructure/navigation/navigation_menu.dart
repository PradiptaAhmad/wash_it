import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';
import 'package:wash_it/presentation/history_page/history_page.screen.dart';

import '../../presentation/home_page/home.screen.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          backgroundColor: primaryColor,
          indicatorColor: Color(0xFFFFFBFE),
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(
              icon: Icon(Iconsax.home),
              selectedIcon: Icon(
                Iconsax.home1,
                color: darkGrey,
              ),
              // New line: selected icon
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(Iconsax.status),
              selectedIcon: Icon(
                Iconsax.status5,
                color: darkGrey,
              ),
              // New line: selected icon
              label: "Status",
            ),
            NavigationDestination(
              icon: Icon(Iconsax.receipt),
              selectedIcon: Icon(
                Iconsax.receipt_11,
                color: darkGrey,
              ),
              // New line: selected icon
              label: "History",
            ),
            NavigationDestination(
              icon: Icon(Iconsax.setting),
              selectedIcon: Icon(
                Iconsax.setting1,
                color: darkGrey,
              ),
              label: "Settings",
            ),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    HomeScreen(),
    Container(color: Colors.blue),
    HistoryPageScreen(),
    Container(color: Colors.yellow),
  ];
}
