import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';
import 'package:wash_it/presentation/profile_page/profile_page.dart';
import 'package:wash_it/presentation/screens.dart';

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
              icon: Icon(
                Icons.home_filled,
                color: darkGrey,
              ),
              selectedIcon: Icon(
                Icons.home_filled,
                color: black,
              ),
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(
                Icons.reorder_rounded,
                color: darkGrey,
              ),
              selectedIcon: Icon(
                Icons.reorder_rounded,
                color: black,
              ),
              label: "Status",
            ),
            NavigationDestination(
              icon: Icon(
                Icons.receipt_rounded,
                color: darkGrey,
              ),
              selectedIcon: Icon(
                Icons.receipt_rounded,
                color: black,
              ),
              label: "History",
            ),
            NavigationDestination(
              icon: Icon(
                Icons.settings,
                color: darkGrey,
              ),
              selectedIcon: Icon(
                Icons.settings,
                color: black,
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
    StatusPageScreen(),
    HistoryPageScreen(),
    ProfilePage(),
  ];
}
